package binary_translations;
use strictures 2;

1;

sub data {
    return (
        "選択"                                     => { tr => "Select", desc => "explains numpad", },
        "提督コマンド"                         => { tr => "Admiral Cmd", },
        "戦略へ"                                  => { tr => "Strategy", },
        "戦略へ	"                                 => { tr => "Strategy", },
        "決定"                                     => { tr => "Choose", },
        "戻る"                                     => { tr => "Return", },
        "戻る　　決定"                         => { tr => "Return  Choose", },
        "選択　　戻る　　決定"             => { tr => "Select  Return  Choose", },
        "作戦難易度を選択してください" => { tr => "Please select strategy difficulty level", },
        "提督名入力"                            => { tr => "Admiral Name", desc => "(this had to be shortened)", },

        "貴官の提督名をお知らせ下さい。\n（１２文字まで入力可能です）" => {
            tr => "Please choose your Admiral's name.\n(Up to 12 characters can be entered.)",
            ok => 'level5/level5_00004.-6 196'
        },
        "配備輸送船数" => { tr => "Cargo ships at sea", },
        "予想獲得資源" => { tr => "Expected Gain", },
        "海上護衛艦隊" => { tr => "Escort Fleet", },
        "回航中"          => { tr => "At Sea", desc => "map screen, tankers at sea, apparently, but also used elsewhere" },
        "未配備"          => { tr => "Undeployd", desc => "one char too long, really need to add glyph aliasing here too" },

        # 艦隊   状態   艦種   艦船名    Lv    耐久   火力   対空   速カ
        # 1st column is whether they are assigned to a fleet, 2nd iss the current state(at sea/damaged/etc, ship type, ship name, Lv, Armor, Firepower, Anti-Air, and Speed
        #[1:06 AM] Knofbep: i think i was wrong about the 2nd column, it's probably just for at-sea
        #[1:06 AM] Knofbep: the damage shows up 2nd to last column
        #[1:06 AM] Knofbep: next to the heart lock
        # https://cdn.discordapp.com/attachments/235919493686231051/522193240510693396/2018-12-11-182050.png
        # https://cdn.discordapp.com/attachments/235919493686231051/522203328923435018/2017-05-02-221035.jpg
        
        # _shii_ninarimashita! maybe here or in csharp, weekly resource bonus
    );
}
