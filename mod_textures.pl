use 5.020;
use strictures 2;
use IO::All -binary;
use Capture::Tiny 'capture';

$|++;
run();

sub run {
    my $skipped;
    say "copying and converting images";
    my $target_path = "../kc_original_unpack_modded/Media/Unity_Assets_Files";
    my @images = grep /\.png$/, io("en/Unity_Assets_Files")->All_Files;
    my %known;
    for my $image (@images) {
        my @file_parts = split /\/|\\/, $image;
        my $source_tex = "../kc_original_unpack/Media/Unity_Assets_Files/$file_parts[2]/$file_parts[4]";
        my $target_tex = "$target_path/$file_parts[2]/$file_parts[4]";
        $_ =~ s/\.png$// for $source_tex, $target_tex;
        die "source texture missing: '$source_tex'" if not -e $source_tex;
        $known{$target_tex}++;
        if ( -e $target_tex ) {
            my $target_age = ( stat $target_tex )[9];
            my $source_age = ( stat "$image" )[9];
            if ( $target_age and $target_age > $source_age ) {
                $skipped++;
                next;
            }
        }
        print "  " . $image->filename;
        io( io->file($target_tex)->filepath )->mkpath;
        io->file($source_tex)->copy($target_tex);
        my $cmd = qq[UnityTexTool/UnityTexTool-x64.exe -c -i "$image" -o "$target_tex"];
        my ( $out, $err, $res ) = capture { system $cmd };
        die "texture conversion error:\n$cmd\n$out\n$err\n$res" if $err or $res;
        die "weird texture conversion result:\n$cmd\n$out\n$err\n$res" if $out !~ /File Created\.\.\./;
    }
    say "\n  skipped $skipped texes that were newer than their translated source png";
    my @found = grep /\.tex$/, io($target_path)->All_Files;
    s/\\/\//g for @found;
    my @unknown = grep !$known{$_}, @found;
    if (@unknown) {
        say join "\n  ", "  deleting unknown texture files:", @unknown;
        io($_)->unlink for @unknown;
    }
    say "done";
    return;
}
