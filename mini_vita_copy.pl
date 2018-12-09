use 5.020;
use strictures 2;
use IO::All -binary;
use Try::Tiny;

$|++;
run();

sub run {
    my $unity_ex = io("../unity_tools/UnityEX.exe")->absolute->pathname;

    try {
        chdir "../kc_translation_mod_candidate/Media";
        system qq["$unity_ex" import $_] for qw( sharedassets2.assets sharedassets3.assets );

        say "copying";
        io->file($_)->copy("e:/rePatch/PCSG00684/Media/$_") for qw( sharedassets2.assets sharedassets3.assets Managed/Assembly-CSharp.dll );
    }
    catch {
        warn $_;
    };

    say "done";
    return;
}
