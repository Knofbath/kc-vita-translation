use 5.020;
use strictures 2;
use IO::All -binary;
use List::Util qw'sum uniq';
use Encode qw' decode encode ';
use utf8;
use Devel::Confess;
use lib '.';
use binary_translations;

run();

sub map_str_to_multi_chars {
    my ( $tr, %prepared ) = @_;
    my @mapped;
    while ( my $l = length $tr ) {
        my $work = $tr;
        while ( my $wl = length $work ) {
            last if $prepared{$work} or $wl == 1;
            $work = substr $work, 0, $wl - 1;
        }
        push @mapped, $work;
        $tr = substr $tr, length $work;
    }
    my $raw = join "|", @mapped;
    my $encoded = encode "UTF-16LE", join "", map $prepared{$_} // $_, @mapped;
    return ( $encoded, $raw );
}

sub pad_multi_char_w_spaces {
    my ( $l_src, $l_tra, $obj ) = @_;
    my $diff = ( $l_src - $l_tra ) / 2;
    $obj->{tr_mapped}{"UTF-16LE"} .= encode( "UTF-16LE", " " ) x $diff;
    return length $obj->{tr_mapped}{"UTF-16LE"};
}

sub map_tr_to_multi_chars {
    my ( $jp, $obj, %prepared ) = @_;
    ( $obj->{tr_mapped}{"UTF-16LE"}, my $raw ) = map_str_to_multi_chars $obj->{tr}, %prepared;
    my $l_src = length encode "UTF-16LE", $jp;
    my $l_tra = length $obj->{tr_mapped}{"UTF-16LE"};
    $l_tra = pad_multi_char_w_spaces $l_src, $l_tra, $obj if $l_tra < $l_src;
    return "translation '$jp' => '$obj->{tr}' doesn't match lengths: $l_src => $l_tra, probable char count: " . ( $l_src / 2 ) . "\ncomposition: $raw\n"
      if $l_src != $l_tra;
    return;
}

sub trim_nl {
    my ($s) = @_;
    $s =~ s/[\r\n]//g;
    return $s;
}

sub add_utf16_mapped {
    my ($dictionary) = @_;
    my $unicode = 0xE000;
    my @pairs = grep $_, map split( /\|/, $_ ), map trim_nl($_), io("font_mod_character_pairs")->getlines;
    my %prepared = map +( $pairs[$_] => chr( $unicode + $_ ) ), 0 .. $#pairs;
    my @too_long = map map_tr_to_multi_chars( $_, $dictionary->{$_}, %prepared ), sort keys $dictionary->%*;
    die join "\n", @too_long, "\n" if @too_long;
    return;
}

sub add_utf8_mapped {
    my ($dictionary) = @_;
    my @too_long;
    for my $key ( keys $dictionary->%* ) {
        my $target_length = length encode "UTF-8", $key;
        my $tr            = $dictionary->{$key}{tr};
        my $tr_length     = length encode "UTF-8", $tr;
        push @too_long, "translation too long for '$key', '$tr': $target_length $tr_length" if $tr_length > $target_length;
        while ( ( my $diff = $target_length - $tr_length ) > 0 ) {    # null width spaces help with formatting, but require 3 bytes
            $tr .= $diff < 3 ? " " : "\x{200B}";
            $tr_length = length encode "UTF-8", $tr;
        }
        push @too_long, "translation too long for '$key', '$tr': $target_length $tr_length" if $tr_length > $target_length;
        $dictionary->{$key}{tr_mapped}{"UTF-8"} = encode "UTF-8", $tr;
    }
    die join "\n", uniq @too_long, "\n" if @too_long;
    return;
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
        $extract = decode $enc, substr $content, $hit - 16 + $offset, 24 + length encode $enc, $jp;
        last if $extract =~ /\Q$jp\E/;
        $offset++;
    }
    my $msg = sprintf "hit '$file_hit' %08x %08x not marked skipped or ok, please verify $jp in >$extract<", $mod, $hit;
    $msg =~ s/\x$_/\\$_/g for 0 .. 9;
    $msg =~ s/\r/\\r/g;
    $msg =~ s/\n/\\n/g;
    say $msg;
}

sub run {
    $|++;
    binmode STDOUT, ":encoding(UTF-8)";
    binmode STDERR, ":encoding(UTF-8)";

    say "prepping dictionary";
    my %tr = binary_translations->data;
    for my $jp ( grep !defined $tr{$_}{tr}, sort keys %tr ) {
        say "no translation for $jp, skipping";
        delete $tr{$jp};
    }
    add_utf8_mapped \%tr;
    add_utf16_mapped \%tr;

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
        enc       => "UTF-16LE",
        fileid    => "a-csharp",
    };
    @list = sort { lc $a->{fileid} cmp lc $b->{fileid} } @list;
    say "prepped";
    my @tr_keys = reverse sort { length $a <=> length $b } sort keys %tr;

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
                    if ( !grep $file_hit eq $_, $obj{ok}->@* and !check_for_null_bracketing $content, $jp, $enc, $hit ) {
                        report_near_miss $file_hit, $hit, $enc, $jp, $content;
                        next;
                    }
                    my $tr = $obj{tr_mapped}{$enc};
                    substr( $content, $hit, length $tr ) = $tr;
                    $tr =~ s/\n/\\n/g;
                    say "hit '$file_hit' done - '$jp' as '$obj{tr}'";
                    $found++;
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
    say "done";
    return;
}
