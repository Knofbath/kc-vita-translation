use 5.020;
use strictures 2;
use IO::All -binary;
use List::Util 'sum';
use Encode qw' decode encode ';
use utf8;

run();

sub get_hits {
    my ( $content, $jp_enc ) = @_;
    my @hits;
    my $pos = 0;
    while ( ( my $hit = index $content, $jp_enc, $pos ) != -1 ) {
        push @hits, $hit;
        $pos = $hit + 1;
    }
    return @hits;
}

sub map_str_to_multi_chars {
    my ( $tr, %prepared ) = @_;
    my $orig = $tr;
    my @mapped;
    while ( my $l = length $tr ) {
        my $work = $tr;
        my $hit;
        while ( my $wl = length $work ) {
            last if $prepared{$work} or $wl == 1;
            say "combination missing: '$work' in '$orig'" if $wl <= 3;
            $work = substr $work, 0, $wl - 1;
        }
        push @mapped, $prepared{$work} // $work;
        $tr = substr $tr, length $work;
    }
    return encode "UTF-16LE", join "", @mapped;
}

sub pad_multi_char_w_spaces {
    my ( $l_src, $l_tra, $obj ) = @_;
    my $diff = ( $l_src - $l_tra ) / 2;
    $obj->{tr_mapped} .= encode( "UTF-16LE", " " ) x $diff;
    return length $obj->{tr_mapped};
}

sub map_tr_to_multi_chars {
    my ( $jp, $obj, %prepared ) = @_;
    $obj->{tr_mapped} = map_str_to_multi_chars $obj->{tr}, %prepared;
    my $l_src = length encode "UTF-16LE", $jp;
    my $l_tra = length $obj->{tr_mapped};
    $l_tra = pad_multi_char_w_spaces $l_src, $l_tra, $obj if $l_tra < $l_src;
    die "translation '$jp' => '$obj->{tr}' doesn't match lengths: $l_src => $l_tra, probable char count: " . ( $l_src / 2 ) . "\n"
      if $l_src != $l_tra;
    return;
}

sub trim_nl {
    my ($s) = @_;
    $s =~ s/[\r\n]//g;
    return $s;
}

sub run {
    $|++;
    binmode STDOUT, ":encoding(UTF-8)";
    binmode STDERR, ":encoding(UTF-8)";

    my %tr = (
        "選択" => {
            tr   => "Select",
            desc => "explains numpad (the skips should be rechecked probably)",
            ok   => 4562125,
            skip => [
                qw( 4487986 4495884 4539834 4539862 4539876 4539906 4548242 4548242 4548404 4550010 4550048 4550486 4552806
                  4562095 4562119 4495298 4563095 4563131 4563513 4564079 4566677 4570003 4595855 4595927 4596751 4596779
                  4596809 4596951 4598553 4598719 4598751 4633240 4698799 4698860 4698896 4699107 4699472 )
            ]
        },
        "提督コマンド" => {
            tr   => "Admiral Command",                                                       # quick menu?
            desc => "usually opens quick menu or changes the buttons to an alternate set",
            ok   => [ 4518854, 4682604 ]
        },
        "戦略へ" => { tr => "Strategy", desc => "leads to fleet strategy management screen", ok => 4518868 },
        "決定"    => { tr => "Choose",   desc => "select the currently chosen option",        ok => 4518802 },
        "戻る"    => { tr => "Return",   desc => "back out of the current screen",            ok => 4518826, skip => [ 4566833, 4682617 ] },
        "らしんばんをまわしてね！" => { desc => "some kind of compass fairy text, using this to find it" },
        "敵艦隊"                            => { desc => "" },
        "見ゅ"                               => { desc => "" },
        "見ゆ"                               => { desc => "" },
        "被弾回避率補正"                => { desc => "" },
    );

    my $unicode  = 0xE000;
    my @pairs    = grep $_, map split( /\|/, $_ ), map trim_nl($_), io("font_mod_character_pairs")->getlines;
    my %prepared = map +( $pairs[$_] => chr( $unicode + $_ ) ), 0 .. $#pairs;

    for my $jp ( grep !$tr{$_}{tr}, sort keys %tr ) {
        say "no translation for $jp, skipping";
        delete $tr{$jp};
    }
    map_tr_to_multi_chars( $_, $tr{$_}, %prepared ) for sort keys %tr;

    my $rel_path = "Media/Managed/Assembly-CSharp.dll";
    my $src      = "../kc_original/$rel_path";
    my $tgt      = "../kc_translation_mod_candidate/$rel_path";

    io($tgt)->unlink if -f $tgt;

    my $content = io($src)->all;

    my ( %found, $error );
    for my $jp ( reverse sort { length $a <=> length $b } sort keys %tr ) {
        my @hits = get_hits $content, encode "UTF-16LE", $jp;
        if ( !@hits ) {
            say "no hits at all for $jp";
            next;
        }
        my %obj = $tr{$jp}->%*;
        $obj{$_} = !defined $obj{$_} ? [] : !ref $obj{$_} ? [ $obj{$_} ] : $obj{$_} for qw( ok skip );
        for my $hit (@hits) {
            next if grep $hit == $_, $obj{skip}->@*;
            if ( !grep $hit == $_, $obj{ok}->@* ) {
                my $mod = $hit - ( $hit % 16 );
                my ( $offset, $extract ) = (0);
                while ( $offset < 3 ) {
                    $extract = decode "UTF-16LE", substr $content, $hit - 16 + $offset, 32 + 16;
                    last if $extract =~ /$jp/;
                    $offset++;
                }
                say sprintf "hit $hit %08x %08x for $jp not marked skipped or ok, please verify $jp in >$extract<", $mod, $hit;
                next;
            }
            substr( $content, $hit, length $obj{tr_mapped} ) = $obj{tr_mapped};
        }
    }

    io($tgt)->print($content);
    say "done";
    return;
}
