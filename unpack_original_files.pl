use 5.010;
use strictures 2;
use IO::All -binary;
use Capture::Tiny 'capture';

run();

sub run {
    my $target = "../kc_original_unpack/Media";
    io($target)->mkpath;
    chdir "../kc_original_unpack/Media";
    my @files = qw( sharedassets2.assets sharedassets3.assets );
    io->file("../../kc_original/Media/$_")->copy(".") for @files;
    my $unity_ex = io("../../unity_tools/UnityEX.exe")->absolute->pathname;
    for my $file (@files) {
        my ( $out, $err, $res ) = capture { system qq["$unity_ex" export $file] };
        warn "\n$out" if $out;
        warn "\n$err" if $err;
        io($file)->unlink;
    }
    return;
}
