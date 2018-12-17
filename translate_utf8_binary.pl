use 5.020;
use strictures 2;
use IO::All -binary;
use List::Util qw'sum uniq min';
use Encode qw' decode encode ';
use utf8;
use lib '.';
use binary_translations;

run();

sub map_str_to_multi_chars {
    my ( $tr, $enc, $length_target, $used, %prepared ) = @_;
    my %rev_prep = reverse %prepared;
    my @glyphs   = sort { length $a <=> length $b } sort keys %prepared;
    my @parts    = split /(?<=\])|(?=\[)/, $tr;

    my $e = sub { encode $enc, join "", @_ };
    my $l = sub { length $e->(@_) };
    return $e->(@parts) if $l->(@parts) == $length_target;

    my ( %seen, @failed, $proc, %closest );
    $proc = sub {    # the lists made before each loop aren't faster, but easier to debug
        my @parts          = @_;
        my $length_current = $l->(@parts);
        my $need_to_shrink = $length_current - $length_target;
        my @to_process     = grep +( $parts[$_] !~ /^\[/ and not $rev_prep{ $parts[$_] } ), 0 .. $#parts;
        for my $i (@to_process) {
            my $part = $parts[$i];
            my @matches = grep index( $part, $_ ) != -1, @glyphs;
            @matches = grep length > ( $need_to_shrink > 25 ? 3 : 1 ), @matches if $need_to_shrink > 0;
            for my $glyph (@matches) {
                my ( $p1, $p2 ) = split /\Q$glyph\E/, $part, 2;
                my @parts2 = @parts;
                splice @parts2, $i, 1, grep length, $p1, $prepared{$glyph}, $p2;
                my $l2   = $l->(@parts2);
                my $diff = $l2 - $length_target;
                return @parts2 if not $diff;

                my $fail = "length in encoding $enc: $length_current -> $l2 : " . join "|", map +( $rev_prep{$_} ? "\$$rev_prep{$_}" : $_ ), @parts2;
                push @{ $closest{ abs $diff } }, $fail;
                push @failed, $fail;
                next if $seen{ $e->(@parts2) };

                my @deeper = $proc->(@parts2);
                $seen{ $e->(@parts2) }++;
                die "tried for too long, add more things to the font mod pairs" if 10_000 == keys %seen;
                return @deeper if @deeper;
            }
        }
        return;
    };

    my @mapped = eval { $proc->(@parts) };
    my $closest_diff = min keys %closest;
    push @failed, map "closest: $_", $closest{$closest_diff}->@* if $closest_diff;
    @mapped = @parts if not @mapped;
    $used->{ $rev_prep{$_} }++ for grep defined $rev_prep{$_}, @mapped;
    return ( $e->(@mapped), uniq @failed );
}

sub map_tr_to_multi_chars {
    my ( $jp, $enc, $obj, $used, %prepared ) = @_;
    my $target_length = length encode $enc, $jp;
    my ( $tr, @failed ) = map_str_to_multi_chars( $obj->{tr}, $enc, $target_length, $used, %prepared );
    my $l_tr = length $tr;
    return "length wanted: $target_length", @failed, "translation '$jp' ($target_length) => '$obj->{tr}' ($l_tr) doesn't match in length"
      if $target_length != $l_tr;
    $obj->{tr_mapped}{$enc} = $tr;
    return;
}

sub trim_nl {
    my ($s) = @_;
    $s =~ s/[\r\n]//g;
    return $s;
}

sub add_mapped {
    my ( $dictionary, $enc, $used, %mapping ) = @_;
    return map map_tr_to_multi_chars( $_, $enc, $dictionary->{$_}, $used, %mapping ), sort keys $dictionary->%*;
}

sub get_hits {
    my ( $content, $jp, $enc ) = @_;
    my @hits;
    my $pos = 0;
    while ( ( my $hit = index $content, encode( $enc, $jp ), $pos ) != -1 ) {
        push @hits, $hit;
        $pos = $hit + 1;
    }
    return @hits;
}

sub check_for_null_bracketing {
    my ( $content, $jp, $enc, $hit ) = @_;
    return if $enc eq "UTF-16LE";
    $jp = encode $enc, $jp;
    my $pre = ord substr $content, $hit - 1, 1;
    my $post = ord substr $content, $hit + length $jp, 1;
    return ( $pre == 0 and $post == 0 );
}

sub utf8_asset_files {
    my $has_find = -e "c:/cygwin/bin/find.exe";
    say "has find: $has_find";
    my $src_dir = "../kc_original_unpack/Media/Unity_Assets_Files/";
    my @list = $has_find ? split /\n/, `c:/cygwin/bin/find "$src_dir" -type f`    #
      : io($src_dir)->All_Files;
    @list = grep !/\.(tex|dds(_\d)*|mat|gobj|shader|txt|xml|ttf|amtc|ani|avatar|cbm|flr|fsb|mesh|obj|physmat2D|rtex|script|snd|[0-9]+)$/, @list;
    @list = map +( ref $_ ? $_ : io($_) ), @list;
    @list = map +{ file => $_, filename => $_->filename, fileparts => [ split /\/|\\/, $_ ], enc => "UTF-8" }, @list;
    $_->{fileid} = join "/", @{ $_->{fileparts} }[ 4 .. $#{ $_->{fileparts} } ] for @list;
    return @list;
}

sub report_near_miss {
    my ( $file_hit, $hit, $enc, $jp, $content ) = @_;
    my $mod = $hit - ( $hit % 16 );
    my ( $offset, $extract ) = (0);
    while ( $offset < 3 ) {
        $extract = decode $enc, substr $content, $hit - 16 + $offset, 28 + length encode $enc, $jp;
        last if $extract =~ /\Q$jp\E/;
        $offset++;
    }
    my $msg = sprintf "hit '%s' %08x %08x not marked skipped or ok, please verify %s in >%s<", $file_hit, $mod, $hit, $jp, $extract;
    $msg =~ s/\x{$_}/■/g for 0 .. 9, "1E", "14", "900";
    $msg =~ s/\r/\\r/g;
    $msg =~ s/\n/\\n/g;
    say $msg;
}

sub duplicate_check {
    my %seen = map +( $_ => 1 ), binary_translations->data;
    my @duplicates = grep $seen{$_} > 1, keys %seen;
    die "following keys are duplicate in dictionary: @duplicates" if @duplicates;
    return;
}

sub run {
    $|++;
    binmode STDOUT, ":encoding(UTF-8)";
    binmode STDERR, ":encoding(UTF-8)";

    say "prepping dictionary";
    my %mapping = do {
        my $unicode = 0xE000;
        my @pairs = grep length $_, map split( /\|/, $_ ), map trim_nl($_), io("font_mod_character_pairs")->getlines;
        map +( $pairs[$_] => chr( $unicode + $_ ) ), 0 .. $#pairs;
    };
    duplicate_check;
    my %tr = binary_translations->data;
    for my $jp ( grep !defined $tr{$_}{tr}, sort keys %tr ) {
        say "no translation for $jp, skipping";
        delete $tr{$jp};
    }
    my %used;
    my @too_long = map add_mapped( \%tr, $_, \%used, %mapping ), "UTF-16LE", "UTF-8";
    s/\n/\\n/g for @too_long;
    die join "\n", @too_long, "\n" if @too_long;
    my @unused = grep !$used{$_}, keys %mapping;
    die "following tuples unused: @unused\nfollowing tuples used: '" . ( join "|", sort keys %used ) . "'\n" if @unused;

    # this converts any single string ok/skip entries into arrays, or fills in empty arrays if there's none
    for my $entry ( values %tr ) {
        $entry->{$_} = !defined $entry->{$_} ? [] : !ref $entry->{$_} ? [ $entry->{$_} ] : $entry->{$_} for qw( ok skip );
    }

    say "grabbing file list";
    my @list = utf8_asset_files;
    push @list, {    #
        file      => io("../kc_original/Media/Managed/Assembly-CSharp.dll"),
        filename  => "Assembly-CSharp.dll",
        fileparts => [ split /\/|\\/, "../kc_original/Media/Managed/Assembly-CSharp.dll" ],
        enc       => [ "UTF-16LE", "UTF-8" ],
        fileid    => "a-csharp",
    };
    @list = sort { lc $a->{fileid} cmp lc $b->{fileid} } @list;
    say "prepped";
    my @tr_keys = reverse sort { length $a <=> length $b } sort keys %tr;
    my %found;
    my %unmatched;
    my %hit;

    for my $file (@list) {
        my $content = $file->{file}->all;
        my $f_enc   = $file->{enc};
        my $found;
        for my $enc ( ref $f_enc ? $f_enc->@* : $f_enc ) {
            for my $jp (@tr_keys) {
                next unless    #
                  my @hits = get_hits $content, $jp, $enc;
                my %obj = $tr{$jp}->%*;
                for my $hit (@hits) {
                    my $file_hit = "$file->{fileid} $hit";
                    next if grep $file_hit eq $_, $obj{skip}->@*;
                    $hit{$jp}++;
                    if ( !grep $file_hit eq $_, $obj{ok}->@* and !check_for_null_bracketing $content, $jp, $enc, $hit ) {
                        $unmatched{$jp}++;
                        report_near_miss $file_hit, $hit, $enc, $jp, $content;
                        next;
                    }
                    substr( $content, $hit, length $_ ) = $_ for $obj{tr_mapped}{$enc};
                    $found++;
                    $found{$jp}++;
                }
            }
        }
        my @file_parts = $file->{fileparts}->@*;
        $file_parts[1] = "kc_original_unpack_modded";
        my $target = join "/", @file_parts;
        if ( !$found ) {
            io($target)->unlink if -e $target;
            next;
        }
        io( io->file($target)->filepath )->mkpath;
        io($target)->print($content);
    }

    say join "\n", "", "strings not always identified confidently:",
      map sprintf( "  %-" . ( 30 - length $_ ) . "s %-30s hit x %3s, nomatch x %3s, match x %3s", $_, $tr{$_}{tr}, $hit{$_}, $unmatched{$_}, $hit{$_} - $unmatched{$_} ),
      reverse sort { length $a <=> length $b } sort keys %unmatched;

    say join "\n", "", "strings found nowhere:", map sprintf( "  %-" . ( 30 - length $_ ) . "s $tr{$_}{tr}", $_ ), grep +( !$found{$_} and !$unmatched{$_} ), @tr_keys;

    say "\ndone";
    return;
}
