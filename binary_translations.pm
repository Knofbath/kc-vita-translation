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
        "戻る"                                     => { tr => "Back", },
        "戻る　　決定"                         => { tr => "Back  Choose", },
        "選択　　戻る　　決定"             => { tr => "Select  Back  Choose", },
        "作戦難易度を選択してください" => { tr => "Please select strategy difficulty level", },
        "提督名入力"                            => { tr => "Admiral Name", desc => "(this had to be shortened)", },

        "貴官の提督名をお知らせ下さい。\n（１２文字まで入力可能です）" => {
            tr => "Please choose your Admiral's name.\n(Up to 12 characters can be entered.)",
            ok => 'level5/level5_00004.-6 196'
        },
        "配備輸送船数" => { tr => "Transports", desc => "Number of deployed shipping vessels, Cargo ships in area" },
        "予想獲得資源" => { tr => "Expected Gain", desc => "Expected acquisition resources (Daily Resource Generation) Fuel, Ammo, Steel, Bauxite per map hex" },
        "海上護衛艦隊" => { tr => "Escort fleet", desc => "Maritime Escort Fleet" },
        "回航中"          => { tr => "At Sea", desc => "map screen, tankers at sea, apparently, but also used elsewhere" },
        "未配備"          => { tr => "No Escort", desc => "Undeployed - one char too long, really need to add glyph aliasing here too" },

        # 艦隊   状態   艦種   艦船名    Lv    耐久   火力   対空   速カ
        # ship table headers
        "艦隊" => { tr => "Fleet", desc => "Fleet Number. Defines which fleet the ship is assigned to. try with adding space at begin for formatting. further adjustements pending results." },
        "状態" => { tr => "State", desc => "Status/Condition of current fleet (red is has acted, blue is on expedition, blue is (maybe) 'on deployment', and blue is at sea again)" },
        "艦種" => { tr => "Class", desc => "Ship Class - maybe 'Hull'" },
        "艦船名" => { tr => "Ship Name", desc => 'prefer "Ship Name" over "name" - requires font substitution.' },
        # Lv - Obviously no need to translate
        "耐久" => { tr => "Health", desc => 'Use Health for clarity as it is already used in other locations. is easier to use "Health" if we can resize it slightly than it would be for changing all the previous uses.' },
        "火力" => { tr => "ATK", desc => "Firepower or ATK, I am still shying from FP or ATK though - Seriosuly this should be easy. The Kanji is literally Fire and Power" },
        "対空" => { tr => "AA", desc => "Anti-air or Air Defense" },
        "速力" => { tr => "Speed", desc => "Try Speed instead of SPD as I would like to check table formatting." },
        #[1:06 AM] Knofbep: the damage shows up 2nd to last column
        #[1:06 AM] Knofbep: next to the heart lock
        # https://cdn.discordapp.com/attachments/235919493686231051/522193240510693396/2018-12-11-182050.png
        # https://cdn.discordapp.com/attachments/235919493686231051/522203328923435018/2017-05-02-221035.jpg

        "新しい週になりました！" => { tr => "A new week is here!", desc => "weekly resource bonus" },
        "新しい月、　　　となりました！" => { tr => "A new month,　　　, is here!", desc => "the month is rendered as a separate string into the gap" },

        "ターンを終了しますか？" => { tr => "Do you want to end your turn?", desc => "Quick Turn End by hitting Square - performed on Operations Screen." },
        "ターン終了" => { tr => "End of Turn", desc => "Quick Turn End, hit Square to confirm" },
        "[12c112]ターン終了[-]" => { tr => "[12c112]End of Turn[-]", desc => "Quick Turn End, hit Square to confirm" },

        # Enemy Raiding
        # these are embedded in sharedassets5/Atlas_RaderHukidashi.tex
        # 護衛艦損傷！        - Escort ship damage! #
        # 輸送船×1隻喪失！    - Transport ship x 1 lost!
        # 輸送船×13隻喪失！   - Transport ship x 13 lost!, example 2
        "護衛艦" => { tr => "Escort", desc => "could use the word 'ship' in there, but too long, need font replacement" },
        "輸送船" => { tr => "Transport", desc => "could use the word 'ship' in there, but too long, need font replacement" },

        # Expedition completion screen (these are probably art)
        # 獲得ボーナス        - Acquisition bonus # can't find as text
        # 海域EXP            - Marine area EXP # can't find as text
        # （基本経験値）       -(Basic experience value) # only as part of a longer text in Assembly-CSharp\local\models\battle\BattleResultModel.cs
        "獲得アイテム" => { tr => "Earned items", desc => "followed by icons and numbers which don't need translation" },
        
        "単縦陣" => { tr => "LineAhead", desc => "and another one that needs font replacement" },
    );
}
