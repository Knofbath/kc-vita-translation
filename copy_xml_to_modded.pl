use 5.020;
use strictures 2;
use IO::All -binary;
use Capture::Tiny 'capture';

$|++;
run();

sub run {
    say "copying translated xml files";
    my @xmls = grep /\.xml$/, io("en/Xml")->All_Files;
    for my $xml (@xmls) {
        my $target_xml = "../kc_original_unpack_modded/Media/StreamingAssets/Xml/tables/master/" . $xml->filename;
        io( io->file($target_xml)->filepath )->mkpath;
        $xml->copy($target_xml);
    }
}
