package csharp_translations;
use strictures 2;
use utf8;

1;

sub data {
    return (
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
        "タイトルに戻る"                => { tr   => "Back to Title", desc => "name choosing menu", ok => 4566823 },
        "提督名入力"                      => { tr   => "Admiral Name Entry", desc => "name choosing menu title, not sure if this one is used", ok => [ 4566487, 4699444 ] },
    );
}
