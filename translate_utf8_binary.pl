use 5.020;
use strictures 2;
use IO::All -binary;
use List::Util 'sum';
use Encode 'encode';
use lib '.';
use binary_translations;

run();

sub run {
    $|++;
    say "prepping dictionary";
    my %tr = binary_translations->data;

    for my $key ( keys %tr ) {
        my $l = length $key;
        die "translation too long for $key, $tr{$key}" if length $tr{$key} > $l;
        while ( my $diff = $l - length $tr{$key} ) {    # null width spaces help with formatting, but require 3 bytes
            $tr{$key} .= $diff < 3 ? " " : encode "UTF-8", "\x{200B}";
        }
        die "translation too long for $key, $tr{$key}" if length $tr{$key} > $l;
    }
    say "grabbing file list";
    my $has_find = -e "c:/cygwin/bin/find.exe";
    say "has find: $has_find";
    my $src_dir = "../kc_original_unpack/Media/Unity_Assets_Files/";
    my @list = $has_find ? split /\n/, `c:/cygwin/bin/find "$src_dir" -type f`    #
      : io($src_dir)->All_Files;
    @list = map ref $_ ? $_ : io($_), grep !/\.(tex|dds|mat|gobj|shader|txt|xml)$/, @list;
    say "prepped";
    for my $file ( sort @list ) {
        my $content = $file->all;
        my ( %found, $error );
        for my $jp ( keys %tr ) {
            next if $content !~ /\0([^\0]*$jp[^\0]*?)\0/;
            my $m = $1;
            if ( length $m > length $jp ) {
                say $file->filename . " found smaller string in bigger: $jp | $m";
                $error++;
                next;
            }
            $found{$jp}++ for $content =~ /\0$jp\0/g;
        }
        my $found_total = sum( 0, values %found );
        my @file_parts = split /\/|\\/, $file;
        $file_parts[1] = "kc_original_unpack_modded";
        my $target = join "/", @file_parts;
        if ( $found_total != 1 or $error ) {
            say $file->filename . " " . ( $error ? "problem" : $found_total ? "too many" : "nothing" ) if $found_total;
            io($target)->unlink if -e $target;
            next;
        }
        my ($to_translate) = keys %found;
        my $translation = $tr{$to_translate};
        $content =~ s/\0$to_translate\0/\0$translation\0/;
        io( io->file($target)->filepath )->mkpath;
        io($target)->print($content);
        say $file->filename . " done - '$translation'";
    }
    say "done";
    return;
}
