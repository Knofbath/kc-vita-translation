use 5.020;
use strictures 2;
use IO::All -binary;
use Digest::SHA1 'sha1_base64';

$|++;
run();

sub run {
    say "copying";
    my $sums_file = "e:/rePatch/PCSG00684/Media/checksums";

    my %known_sums = -e $sums_file ? split /\n|\t/, io($sums_file)->all : ();

    my %sums;

    my @files = io("../kc_translation_mod_candidate")->All_Files;
    for my $file (@files) {
        print "$file ";
        my @file_parts = split /\/|\\/, $file;
        shift @file_parts for 1 .. 3;
        my $path = join "/", @file_parts;
        $sums{$path} = sha1_base64 $file->all;
        if ( $sums{$path} eq $known_sums{$path} ) {
            say " already on vita, skipping";
            next;
        }
        say "copying";
        $file->copy("e:/rePatch/PCSG00684/Media/$path");
    }

    io($sums_file)->print( join "\n", map "$_\t$sums{$_}", sort keys %sums );

    say "done";
    return;
}
