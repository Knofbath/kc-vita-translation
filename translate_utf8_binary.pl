use 5.020;
use strictures 2;
use IO::All -binary;
use List::Util qw'sum uniq';
use Encode qw' decode encode ';
use lib '.';
use binary_translations;

run();

sub get_hits {
    my ( $content, $jp_enc ) = @_;
    my @hits;
    my $pos = 0;
    while ( ( my $hit = index $content, $jp_enc, $pos ) != -1 ) {
        push @hits, $hit;
        $pos = $hit + 1;
    }
    return @hits;
}

sub check_for_null_bracketing {
    my ( $content, $jp, $hit ) = @_;
    my $pre = ord substr $content, $hit - 1, 1;
    my $post = ord substr $content, $hit + length $jp, 1;
    return ( $pre == 0 and $post == 0 );
}

sub run {
    $|++;
    binmode STDOUT, ":encoding(UTF-8)";
    binmode STDERR, ":encoding(UTF-8)";

    say "prepping dictionary";
    my %tr = binary_translations->data;

    my @too_long;
    for my $key ( keys %tr ) {
        my $err_key = decode "UTF-8", $key;
        my $l       = length $key;
        my $tr      = $tr{$key}{tr};
        push @too_long, "translation too long for '$err_key', '$tr': $l " . length $tr if length $tr > $l;
        while ( ( my $diff = $l - length $tr ) > 0 ) {    # null width spaces help with formatting, but require 3 bytes
            $tr .= $diff < 3 ? " " : encode "UTF-8", "\x{200B}";
        }
        push @too_long, "translation too long for '$err_key', '$tr': $l " . length $tr if length $tr > $l;
        $tr{$key}{tr_mapped} = $tr;
    }
    die join "\n", uniq @too_long, "\n" if @too_long;
    say "grabbing file list";
    my $has_find = -e "c:/cygwin/bin/find.exe";
    say "has find: $has_find";
    my $src_dir = "../kc_original_unpack/Media/Unity_Assets_Files/";
    my @list = $has_find ? split /\n/, `c:/cygwin/bin/find "$src_dir" -type f`    #
      : io($src_dir)->All_Files;
    @list = grep !/\.(tex|dds(_\d)*|mat|gobj|shader|txt|xml|ttf|amtc|ani|avatar|cbm|flr|fsb|mesh|obj|physmat2D|rtex|script|snd|[0-9]+)$/, @list;
    say "prepped";
    my @tr_keys = reverse sort { length $a <=> length $b } keys %tr;

    for my $file ( sort @list ) {
        $file = io($file) if not ref $file;
        my $content    = $file->all;
        my $filename   = $file->filename;
        my @file_parts = split /\/|\\/, $file;
        my $file_id    = join "/", @file_parts[ 4 .. $#file_parts ];
        my $found;
        for my $jp (@tr_keys) {
            next unless    #
              my @hits = get_hits $content, $jp;
            my %obj = $tr{$jp}->%*;
            $obj{$_} = !defined $obj{$_} ? [] : !ref $obj{$_} ? [ $obj{$_} ] : $obj{$_} for qw( ok skip );
            for my $hit (@hits) {
                my $file_hit = "$file_id $hit";
                next if grep $file_hit eq $_, $obj{skip}->@*;
                if ( !grep $file_hit eq $_, $obj{ok}->@* and !check_for_null_bracketing $content, $jp, $hit ) {
                    my $mod = $hit - ( $hit % 16 );
                    my ( $offset, $extract ) = (0);
                    my $search = decode "UTF-8", $jp;
                    while ( $offset < 3 ) {
                        $extract = decode "UTF-8", substr $content, $hit - 16 + $offset, 32 + 16;
                        last if $extract =~ /\Q$search\E/;
                        $offset++;
                    }
                    my $msg = sprintf "hit '$file_hit' %08x %08x not marked skipped or ok, please verify $search in >$extract<", $mod, $hit;
                    $msg =~ s/\0/\\0/g;
                    $msg =~ s/\x7/\\7/g;
                    $msg =~ s/\r/\\r/g;
                    $msg =~ s/\n/\\n/g;
                    say $msg;
                    next;
                }
                substr( $content, $hit, length $obj{tr_mapped} ) = $obj{tr_mapped};
                my $final = $obj{tr_mapped};
                $final =~ s/\n/\\n/g;
                say "$filename done - '$final'";
                $found++;
            }
        }
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
