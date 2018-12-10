use 5.010;
use strictures 2;
use IO::All -binary;
use Capture::Tiny 'capture';

run();

sub run {
    my $target = "../kc_original_unpack/Media";
    io($target)->mkpath;
    chdir "../kc_original_unpack/Media";
    $_->copy(".") for grep !/resources\.resource/, io("../../kc_original/Media/")->all_files;
    my $unity_ex = io("../../unity_tools/UnityEX.exe")->absolute->pathname;
    for my $file ( io(".")->all_files ) {
        my ( $out, $err, $res ) = capture { system qq["$unity_ex" export $file] };
        warn "\n$out" if $out;
        warn "\n$err" if $err;
        io($file)->unlink;
    }
    return;
}
