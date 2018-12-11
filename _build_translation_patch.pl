use 5.020;
use strictures 2;

$|++;
run();

sub run {
    $|++;
    say "you might want to run this to enable kanji: chcp 65001";
    say "your terminal's font will need to support kanji too (e.g. MS Gothic, MS Mincho)\n";

    while (1) {
        system qq[perl translate_utf16_binary.pl];
        print "do you wish to repeat the CSharp translation build? [n]";
        my $in = <>;
        chomp $in;
        last if !$in or $in =~ /^n/;
    }
    print "do you wish to proceed [y]";
    my $in = <>;
    chomp $in;
    return if $in and $in !~ /^y/;

    system qq[perl translate_utf8_binary.pl];
    system qq[perl modify_fonts_and_inject.pl];
    system qq[perl mod_textures.pl];
    system qq[perl copy_xml_to_modded.pl];
    system qq[perl import_files_to_assets.pl];
    try_copy();

    say "all done";
    return;
}

sub try_copy {
    print "ready to copy? [y]";
    my $in .= <>;    # i have no idea why i need to do this twice
    $in .= <>;
    $in =~ s/[\r\n]//g;
    return if $in and $in !~ /^y/;
    system qq[perl vita_copy.pl];
    return;
}
