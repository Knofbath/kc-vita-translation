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
    @list = map ref $_ ? $_ : io($_), grep !/\.(tex|dds|mat|gobj|shader|txt|xml|ttf)$/, @list;
    say "prepped";
    my @tr_keys = reverse sort { length $a <=> length $b } keys %tr;

    for my $file ( sort @list ) {
        my $content = $file->all;
        my ( $found, $error );
        for my $jp (@tr_keys) {
            next if $content !~ /\0([^\0]*$jp[^\0]*?)\0/;
            my $m = $1;
            if ( length $m > length $jp ) {
                say $file->filename . " found smaller string in bigger: $jp | $m";
                $error++;
                next;
            }
            $found = $jp;
            last;
        }
        my @file_parts = split /\/|\\/, $file;
        $file_parts[1] = "kc_original_unpack_modded";
        my $target = join "/", @file_parts;
        if ( !$found or $error ) {
            say $file->filename . " " . ( $error ? "problem" : "nothing" ) if $found;
            io($target)->unlink if -e $target;
            next;
        }
        my $translation = $tr{$found};
        $content =~ s/\0$found\0/\0$translation\0/g;
        io( io->file($target)->filepath )->mkpath;
        io($target)->print($content);
        say $file->filename . " done - '$translation'";
    }
    say "done";
    return;
}
