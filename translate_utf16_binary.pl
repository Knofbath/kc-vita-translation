use 5.020;
use strictures 2;
use IO::All -binary;
use List::Util 'sum';
use Encode qw' decode encode ';
use utf8;
use lib '.';
use csharp_translations;

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
    my @mapped;
    while ( my $l = length $tr ) {
        my $work = $tr;
        while ( my $wl = length $work ) {
            last if $prepared{$work} or $wl == 1;
            $work = substr $work, 0, $wl - 1;
        }
        push @mapped, $work;
        $tr = substr $tr, length $work;
    }
    my $raw = join "|", @mapped;
    my $encoded = encode "UTF-16LE", join "", map $prepared{$_} // $_, @mapped;
    return ( $encoded, $raw );
}

sub pad_multi_char_w_spaces {
    my ( $l_src, $l_tra, $obj ) = @_;
    my $diff = ( $l_src - $l_tra ) / 2;
    $obj->{tr_mapped} .= encode( "UTF-16LE", " " ) x $diff;
    return length $obj->{tr_mapped};
}

sub map_tr_to_multi_chars {
    my ( $jp, $obj, %prepared ) = @_;
    ( $obj->{tr_mapped}, my $raw ) = map_str_to_multi_chars $obj->{tr}, %prepared;
    my $l_src = length encode "UTF-16LE", $jp;
    my $l_tra = length $obj->{tr_mapped};
    $l_tra = pad_multi_char_w_spaces $l_src, $l_tra, $obj if $l_tra < $l_src;
    return "translation '$jp' => '$obj->{tr}' doesn't match lengths: $l_src => $l_tra, probable char count: " . ( $l_src / 2 ) . "\ncomposition: $raw\n"
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

    my %tr = csharp_translations->data;

    my $unicode  = 0xE000;
    my @pairs    = grep $_, map split( /\|/, $_ ), map trim_nl($_), io("font_mod_character_pairs")->getlines;
    my %prepared = map +( $pairs[$_] => chr( $unicode + $_ ) ), 0 .. $#pairs;

    for my $jp ( grep !defined $tr{$_}{tr}, sort keys %tr ) {
        say "no translation for $jp, skipping";
        delete $tr{$jp};
    }
    my @too_long = map map_tr_to_multi_chars( $_, $tr{$_}, %prepared ), sort keys %tr;
    die join "\n", @too_long, "\n" if @too_long;

    my $rel_path = "Media/Managed/Assembly-CSharp.dll";
    my $src      = "../kc_original/$rel_path";
    my $tgt      = "../kc_original_unpack_modded/$rel_path";

    io($tgt)->unlink if -f $tgt;

    my $content = io($src)->all;

    say "note that this will attempt to output useful dumps, but sometimes they go corrupt, fiddling or asking mithaldu is your best bet";

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
                    $extract = decode "UTF-16LE", substr $content, $hit - 8 + $offset, 16 + 2 * length encode "UTF-16LE", $jp;
                    last if $extract =~ /\Q$jp\E/;
                    $offset++;
                }
                my $msg = sprintf "hit $hit %08x %08x for $jp not marked skipped or ok, please verify $jp in >$extract<", $mod, $hit;
                $msg =~ s/\x$_/\\$_/g for 0 .. 9;
                $msg =~ s/\r/\\r/g;
                $msg =~ s/\n/\\n/g;
                say $msg;
                next;
            }
            substr( $content, $hit, length $obj{tr_mapped} ) = $obj{tr_mapped};
        }
    }

    io( io->file($tgt)->filepath )->mkpath;
    io($tgt)->print($content);
    say "done";
    return;
}
