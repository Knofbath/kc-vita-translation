use 5.010;
use strictures 2;
use IO::All -binary;
use Capture::Tiny 'capture';

run();

# this whole thing works a bit oddly. since asset files are interlinked, we need
# the resources.resource file despite never unpacking it, and we also can only
# delete things after unpacking.

sub run {
    my $target = "../kc_original_unpack/Media";
    io($target)->mkpath;
    chdir "../kc_original_unpack/Media";
    my @files = io("../../kc_original/Media/")->all_files;
    $_->copy(".") for @files;
    my $unity_ex = io("../../unity_tools/UnityEX.exe")->absolute->pathname;
    for my $file ( grep !/resources\.resource/, io(".")->all_files ) {
        say "unpacking file $file'";
        my ( $out, $err, $res ) = capture { system qq["$unity_ex" export $file] };
        warn "\n$out" if $out;
        warn "\n$err" if $err;
    }
    io($_)->unlink for @files;
    return;
}
