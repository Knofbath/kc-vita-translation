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
        "敵艦隊"             => { desc => "" },
        "見ゅ"                => { desc => "" },
        "見ゆ"                => { desc => "" },
        "被弾回避率補正" => { desc => "" },
        "タイトルに戻る" => { tr   => "Back to Title", desc => "name choosing menu", ok => 4566823 },
        "提督名入力"       => { tr   => "Admiral Name Entry", desc => "name choosing menu title, not sure if this one is used", ok => [ 4566487, 4699444 ] },

        # https://www.thoughtco.com/can-you-tell-me-the-old-names-of-the-months-2027868
        #this.monthFormat.MonthNames = new string[13]
        #{ "睦月", "如月", "弥生", "卯月", "皐月", "水無月", "文月", "葉月", "長月", "神無月", "霜月", "師走", string.Empty };
        "睦月"    => { tr => "Jan", ok => 4594475 },
        "如月"    => { tr => "Feb", ok => 4594481 },
        "弥生"    => { tr => "Mar", ok => 4594487 },
        "卯月"    => { tr => "Apr", ok => 4594493 },
        "皐月"    => { tr => "May", ok => 4594499 },
        "水無月" => { tr => "Jun", ok => 4594505 },
        "文月"    => { tr => "Jul", ok => 4594513 },
        "葉月"    => { tr => "Aug", ok => 4594519 },
        "長月"    => { tr => "Sep", ok => 4594525 },
        "神無月" => { tr => "Oct", ok => 4594531 },
        "霜月"    => { tr => "Nov", ok => 4594539 },
        "師走"    => { tr => "Dec", ok => 4594545 },

        #this.yearFormat = new Dictionary<string, string>()
        #{ {"0","零"},{"1","壱"},{"2","弐"},{"3","参"},{"4","肆"},{"5","伍"},{"6","陸"},{"7","質"},{"8","捌"},{"9","玖"},{"10","拾"} };
        "零" => { tr => "0",  ok => 4594551 },
        "壱" => { tr => "1",  ok => 4594555 },
        "弐" => { tr => "2",  ok => 4594559 },
        "参" => { tr => "3",  ok => 4594563 },
        "肆" => { tr => "4",  ok => 4594567 },
        "伍" => { tr => "5",  ok => 4594571 },
        "陸" => { tr => "6",  ok => 4594575 },
        "質" => { tr => "7",  ok => 4594579 },
        "捌" => { tr => "8",  ok => 4594583 },
        "玖" => { tr => "9",  ok => 4594587 },
        "拾" => { tr => "10", ok => 4594597 },

        #"海上護衛艦隊" => { tr => "Return", desc => "" }, # this one is part of some strings in here
        "  貴官の提督名をお知らせ下さい。(" => { tr => "Please choose your Admiral's name. (Up to ", ok => 4566537 },
        "文字まで入力可能です)"                  => { tr => " characters can be entered.)",               ok => 4566575 },

        "ゲーム開始" => { tr => "Game Starters", ok => [ 4566659, 4699455 ], desc => "title of game starter set selection screen" },
        "初期艦選択" => {
            tr => "Starter Ship Selection",
            ok => [
                4566671,
                4699466,    # unsure about this one
            ],
            desc => "not sure, think title of the screen after the set"
        },
        "チュートリアル" => {
            tr => "Tutorial",
            ok => [
                4566683,
                4699477,    # unsure about this one
            ]
        },

        "獲得アイテム:{0}" => { tr => "Earned items:{0}", ok => 4601141, desc => "tbh not sure where exactly this is" },

        # this.Title.text = monthName.Length != 2 ? "新しい月、　　　　となりました！" : "新しい月、　　　となりました！";
        "新しい月、　　　　となりました！" => { tr => "A new month,　　　　, is here!", ok => 4572711, desc => "the month is rendered as a separate string into the gap" },
        "新しい月、　　　となりました！"    => { tr => "A new month,　　　, is here!",    ok => 4572679, desc => "the month is rendered as a separate string into the gap" },

        # Map screen
        "どこに進む？" => {
            tr   => "Where to now?",
            ok   => [ 4564133, 4698584 ],                               # i am VERY unsure about these hits, they'll require verification
            desc => q["Where do you want to go?" or " Where to now?"]
        },

        # Compass Fairy with magic hat
        "らしんばんをまわしてね！" => {
            tr   => "Spin the compass please!",
            ok   => 4564621,
            desc => "a compass fairy text. these are in csharp, but the decompiler doesn't see them. maybe these could default to a cute way of speaking?"
        },
        # Compass Fairy with bob haircut
        "よーし、らしんばんまわすよー！" => { tr => "Alright, I'll spin the compass!", ok => 4564557 },
        "えいっ"                                     => {
            tr => "Ey!",
            ok => 4564647,
            desc =>
q[it is a sound uttered/made when someone is exerting force, or throwing something. you would be best ignoring the "っ" for now. It is not a tsu. "つ" is. I am nt reallt set to explain sokuon and glottal stops.]
        },
        "それっ" => { tr => "Take that!", ok => 4564655, desc => q["Take That!" or "That!" - can also use "This". remember implied words. once more with the っ. (i think it could also be "There!")] },

        # Battle formation screen
        "陣形を選択してください。" => { tr => "Please select the formation.", ok => [ 4564073, 4698793 ] },
        "単縦陣" => { tr => "Line Ahead", ok => 4501426 },
        "複縦陣" => { tr => "Double Line", ok => 4501434 },
        "輪形陣" => { tr => "Diamond", ok => 4501442 },
        "梯形陣" => { tr => "Echelon", ok => 4501450 },
        "単横陣" => { tr => "Line Abreast", ok => 4501458, desc => "these are all the accepted translations already. so yes. See if you can do a carriage return after Line ina all of these." },
    );
}
