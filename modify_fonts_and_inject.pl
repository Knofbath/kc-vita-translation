use 5.010;
use strictures 2;
use IO::All -binary;
use Capture::Tiny 'capture';

run();

sub run {
    my $ff            = "C:/Program Files (x86)/FontForgeBuilds/bin/fontforge.exe";
    my $candidate_dir = "../kc_original_unpack_modded";
    my @fonts         = (
        {
            name        => "A-OTF-UDShinGoPro-Regular",
            target_path => "Media/Unity_Assets_Files/sharedassets3",
            src         => "fonts/ume-pgs4.ttf"
        },
        {
            name        => "A-OTF-ShinGoPro-Regular",
            target_path => "Media/Unity_Assets_Files/sharedassets2",
            src         => "../kc_original_unpack/Media/Unity_Assets_Files/sharedassets3/A-OTF-UDShinGoPro-Regular.ttf"
        },
    );
    io("../fonts")->mkdir if !-d "../fonts";
    mod_font( $ff, $candidate_dir, $_->%* ) for @fonts;
    say "done with fonts";
    return;
}

sub mod_font {
    my ( $ff, $candidate_dir, %font ) = @_;
    say "processing font '$font{name}'";

    my $target_path = "$candidate_dir/$font{target_path}";
    my $target_body = "$target_path/$font{name}";
    my $target_age  = ( stat "$target_body.ttf" )[9];
    my $source_age  = ( stat "font_mod_character_pairs" )[9];
    if ( $target_age and $target_age > $source_age ) {
        say "font was generated after last change to char tuples, skipping";
        return;
    }

    if ( !-e "../fonts/$font{name}.sfdir" ) {
        say "preparing font from source with empty PUA glyphs and guaranteed space glyph";
        my ( $out, $err, $res ) = capture { system(qq["$ff" -script prepare_new_font.ff "$font{src}" "../fonts/$font{name}.sfdir"]) };
        $err =~ s/^Copyright.*\n(^ .*\n)+//m;
        $err =~ s/^The following table.*ignored.*\n(^ .*\n)+//m;
        $err =~ s/^Warning:.*\n(^ .*\n)+//mg;
        $err =~ s/^This font contains both.*\n(^ .*\n)+//m;
        $out =~ s/^log:.*\n//mg;
        die "error:\nout:\n$out\nerr:\n$err\nres: $res\n" if $out or $err or $res;
    }

    say "modding font with multi-glyphs";
    my ( $out, $err, $res ) = capture { system(qq[python font_mod_run.py "$font{name}"]) };
    die "error:\nout:\n$out\nerr:\n$err\nres: $res\n" if $out or $err or $res;

    say "generating font file from mod dir";
    io($target_path)->mkpath;
    my $temp_target = "$target_body.otf";
    my $mod_dir     = "../fonts/$font{name}_mod.sfdir";
    my ( $out2, $err2, $res2 ) = capture { system(qq["$ff" -script generate_font_from_dir.ff "$mod_dir" "$temp_target"]) };
    $err2 =~ s/^Copyright.*\n(^ .*\n)+//m;
    $err2 =~ s/^Lookup sub table.*is too big.*\n//m;
    $err2 =~ s/^Lookup .* has an\n(^  .*\n)+//m;
    die "error:\nout:\n$out2\nerr:\n$err2\nres: $res2\n" if $out2 or $err2 or $res2;

    # the extension here is for compatibility. the fonts in kc are OTF, but
    # have the extension ttf, so we generate the replacements to match
    say "fixing final extension";
    io($temp_target)->rename("$target_body.ttf");
    say "done\n";
    return;
}
