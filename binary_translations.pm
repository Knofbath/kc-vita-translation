package binary_translations;
use strictures 2;
use utf8;

1;

sub data {
    return (
        "選択"                                     => {
            tr   => "Select",
            desc => "explains numpad (the skips should be rechecked probably)",
            ok   => 'a-csharp 4562125',
            skip => [
                map "a-csharp $_", qw( 4487986 4495884 4539834 4539862 4539876 4539906 4548242 4548242 4548404 4550010 4550048 4550486 4552806
                  4562095 4562119 4495298 4563095 4563131 4563513 4564079 4566677 4570003 4595855 4595927 4596751 4596779
                  4596809 4596951 4598553 4598719 4598751 4633240 4698799 4698860 4698896 4699107 4699472 )
            ]
        },
        "提督コマンド"                         => {
            tr   => "Admiral Command",                                                       # quick menu?
            desc => "usually opens quick menu or changes the buttons to an alternate set",
            ok   => [ 'a-csharp 4518854', 'a-csharp 4682604' ]
        },
        "戦略へ"                                  => {
            tr => "Strategy",
            desc => "leads to fleet strategy management screen",
            ok => ['level22/level22_00034.-4 196', 'sharedassets5/sharedassets5_00617.-4 196', 'a-csharp 4518868'] },
        "決定"                                     => { tr => "Choose", desc => "select the currently chosen option", ok => 'a-csharp 4518802' },
        "戻る" => { tr => "Back", desc => "back out of the current screen", ok => 'a-csharp 4518826', skip => [ 'a-csharp 4566833', 'a-csharp 4682617' ] },
        "戻る　　決定"                         => { tr => "Back  Choose", },
        "選択　　戻る　　決定"             => { tr => "Select  Back  Choose", },

        "作戦難易度を選択してください" => { tr => "Please select strategy difficulty level", },
        "タイトルに戻る" => { tr   => "Back to Title", desc => "name choosing menu", ok => 'a-csharp 4566823' },
        "提督名入力"       => { tr   => "Admiral Name Entry", desc => "name choosing menu title, not sure if this one is used", ok => [ 'a-csharp 4566487', 'a-csharp 4699444' ] },
        #"海上護衛艦隊" => { tr => "Return", desc => "" }, # this one is part of some strings in here
        "  貴官の提督名をお知らせ下さい。(" => { tr => "Please choose your Admiral's name. (Up to ", ok => 'a-csharp 4566537' },
        "文字まで入力可能です)"                  => { tr => " characters can be entered.)",               ok => 'a-csharp 4566575' },
        "貴官の提督名をお知らせ下さい。\n（１２文字まで入力可能です）" => {
            tr => "Please choose your Admiral's name.\n(Up to 12 characters can be entered.)",
            ok => 'level5/level5_00004.-6 196'
        },
        "ゲーム開始" => { tr => "Game Starters", ok => [ 'a-csharp 4566659', 'a-csharp 4699455' ], desc => "title of game starter set selection screen" },
        "初期艦選択" => {
            tr => "Starter Ship Selection",
            ok => [
                'a-csharp 4566671',
                'a-csharp 4699466',    # unsure about this one
            ],
            desc => "not sure, think title of the screen after the set"
        },
        "チュートリアル" => {
            tr => "Tutorial",
            ok => [
                'a-csharp 4566683',
                'a-csharp 4699477',    # unsure about this one
            ]
        },

        "配備輸送船数" => { tr => "Transports", desc => "Number of deployed shipping vessels, Cargo ships in area" },
        "予想獲得資源" => { tr => "Expected Gain", desc => "Expected acquisition resources (Daily Resource Generation) Fuel, Ammo, Steel, Bauxite per map hex" },
        "海上護衛艦隊" => { tr => "Escort fleet", desc => "Maritime Escort Fleet" },
        "回航中"          => { tr => "At Sea", desc => "map screen, tankers at sea, apparently, but also used elsewhere" },
        "未配備"          => { tr => "Undeployed", desc => "Undeployed - one char too long, really need to add glyph aliasing here too" },

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

        # this.Title.text = monthName.Length != 2 ? "新しい月、　　　　となりました！" : "新しい月、　　　となりました！";
        "新しい月、　　　　となりました！" => { tr => "A new month,　　　　, is here!", ok => 'a-csharp 4572711', desc => "the month is rendered as a separate string into the gap" },
        "新しい月、　　　となりました！"    => { tr => "A new month,　　　, is here!",    ok => 'a-csharp 4572679', desc => "the month is rendered as a separate string into the gap" },
        "新しい週になりました！" => { tr => "A new week is here!", desc => "weekly resource bonus" },

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

        "敵艦隊"             => { desc => "" },
        "見ゅ"                => { desc => "" },
        "見ゆ"                => { desc => "" },
        "被弾回避率補正" => { desc => "" },

        # https://www.thoughtco.com/can-you-tell-me-the-old-names-of-the-months-2027868
        #this.monthFormat.MonthNames = new string[13]
        #{ "睦月", "如月", "弥生", "卯月", "皐月", "水無月", "文月", "葉月", "長月", "神無月", "霜月", "師走", string.Empty };
        "睦月"    => { tr => "Jan", ok => 'a-csharp 4594475' },
        "如月"    => { tr => "Feb", ok => 'a-csharp 4594481' },
        "弥生"    => { tr => "Mar", ok => 'a-csharp 4594487' },
        "卯月"    => { tr => "Apr", ok => 'a-csharp 4594493' },
        "皐月"    => { tr => "May", ok => 'a-csharp 4594499' },
        "水無月" => { tr => "Jun", ok => 'a-csharp 4594505' },
        "文月"    => { tr => "Jul", ok => 'a-csharp 4594513' },
        "葉月"    => { tr => "Aug", ok => 'a-csharp 4594519' },
        "長月"    => { tr => "Sep", ok => 'a-csharp 4594525' },
        "神無月" => { tr => "Oct", ok => 'a-csharp 4594531' },
        "霜月"    => { tr => "Nov", ok => 'a-csharp 4594539' },
        "師走"    => { tr => "Dec", ok => 'a-csharp 4594545' },

        #this.yearFormat = new Dictionary<string, string>()
        #{ {"0","零"},{"1","壱"},{"2","弐"},{"3","参"},{"4","肆"},{"5","伍"},{"6","陸"},{"7","質"},{"8","捌"},{"9","玖"},{"10","拾"} };
        "零" => { tr => "0",  ok => 'a-csharp 4594551' },
        "壱" => { tr => "1",  ok => 'a-csharp 4594555' },
        "弐" => { tr => "2",  ok => 'a-csharp 4594559' },
        "参" => { tr => "3",  ok => 'a-csharp 4594563' },
        "肆" => { tr => "4",  ok => 'a-csharp 4594567' },
        "伍" => { tr => "5",  ok => 'a-csharp 4594571' },
        "陸" => { tr => "6",  ok => 'a-csharp 4594575' },
        "質" => { tr => "7",  ok => 'a-csharp 4594579' },
        "捌" => { tr => "8",  ok => 'a-csharp 4594583' },
        "玖" => { tr => "9",  ok => 'a-csharp 4594587' },
        "拾" => { tr => "10", ok => 'a-csharp 4594597' },

        "獲得アイテム:{0}" => { tr => "Earned items:{0}", ok => 'a-csharp 4601141', desc => "tbh not sure where exactly this is" },

        # Map screen
        "どこに進む？" => {
            tr   => "Where to now?",
            ok   => [ 'a-csharp 4564133', 'a-csharp 4698584' ],                               # i am VERY unsure about these hits, they'll require verification
            desc => q["Where do you want to go?" or " Where to now?"]
        },

        # Compass Fairy with magic hat
        "らしんばんをまわしてね！" => {
            tr   => "Spin the compass please!",
            ok   => 'a-csharp 4564621',
            desc => "a compass fairy text. these are in csharp, but the decompiler doesn't see them. maybe these could default to a cute way of speaking?"
        },
        # Compass Fairy with bob haircut
        "よーし、らしんばんまわすよー！" => { tr => "Alright, I'll spin the compass!", ok => 'a-csharp 4564557' },
        "えいっ"                                     => {
            tr => "Ey!",
            ok => 'a-csharp 4564647',
            desc =>
q[it is a sound uttered/made when someone is exerting force, or throwing something. you would be best ignoring the "っ" for now. It is not a tsu. "つ" is. I am nt reallt set to explain sokuon and glottal stops.]
        },
        "それっ" => { tr => "Take that!", ok => 'a-csharp 4564655', desc => q["Take That!" or "That!" - can also use "This". remember implied words. once more with the っ. (i think it could also be "There!")] },

        # Battle formation screen
        "陣形を選択してください。" => { tr => "Please select the formation.", ok => [ 'a-csharp 4564073', 'a-csharp 4698793' ] },
        "単縦陣" => { tr => "Line Ahead", ok => 'a-csharp 4501426' },
        "複縦陣" => { tr => "Double Line", ok => 'a-csharp 4501434' },
        "輪形陣" => { tr => "Diamond", ok => 'a-csharp 4501442' },
        "梯形陣" => { tr => "Echelon", ok => 'a-csharp 4501450' },
        "単横陣" => { tr => "Line Abreast", ok => 'a-csharp 4501458', desc => "these are all the accepted translations already. so yes. See if you can do a carriage return after Line ina all of these." },
        
        
        # 獲得可能資材 - "Materials Available" [OC] that means out of context and i reserve the right to edit later.
        # 残り輸送船数 - "Ships Remaining" [OC]
        # 必要輸送船数 - "Required Number of Ships" [OC]
        
        # Compass fairy with magic hat
        # https://cdn.discordapp.com/attachments/235919493686231051/523259704890097675/2018-12-05-071704.png
        # Compass fairy with bob haircut
        # https://cdn.discordapp.com/attachments/235919493686231051/523259707331313713/2018-12-05-102944.png
        # ここっ - "Here!" but with exertion.
        # Compass fairy with chick on head
        # https://cdn.discordapp.com/attachments/235919493686231051/523259713480163328/2018-12-13-232523.png
        # はやくはやくー！ - "Hurry! Hurry!" - i may localize it a little better. "C'mon! Hurry up!" alternate, more localized. Kind of like it myself.
        # えいえいえーいっ - "" I need to see it in use for flavour. Knofbath translation does not feel right at this time.
        # とまれ一つ - "And Another One" i will come back to this one. more context needed.
        # Compass fairy who is sleepy
        # https://cdn.discordapp.com/attachments/235919493686231051/523259716009328658/2018-12-14-010022.png
        # えー？らしんばん、まわすのー？ - "Please Spin The Compass!" or "Spin The Compass Please" - this is extremely localized. for a more literal use, "What? Spin the compass." or maybe, "What? Spin The Compass Already."
        # https://cdn.discordapp.com/attachments/235919493686231051/523021829737283585/2018-12-14-010344.png
        # 。。。ん。         -  "...un!" - grunt like sound - [Previous is Depriciated - and context matters : "Huh?" -  Literally "....n." - Maybe use "Wha?" [t intentioanlly omitted]]
        # https://cdn.discordapp.com/attachments/235919493686231051/523021901270876172/2018-12-14-010056.png
        # 。。。。。。あい    -  "...aww" - Literally "...ai" - Or, maybe she is just making a sound. I am going to play with this some.
        
        # 艦隊の針路を選択できます。 - "Plot the fleets course."
        # 提督、どちらの針路を選択しますか？ - "Admiral, pick a course?" could be "Admiral, which course do you prefer?"

        # この艦隊で出撃しますか？ - "Sortie this fleet?"
        # ※艦娘保有数が上限に近いため、新しい艦娘と邂逅できない可能性があります。 - "※If you have too many Ship Girls, there is a possibility of not getting a Ship Girl reward." - Edited for consistency. 
        # ※艦娘保有数が上限に達しているため、新しい艦娘との邂逅はできません。    - "※You have reached your limit of Ship Girls and can not accept your reward." - red, ships full
        # https://cdn.discordapp.com/attachments/235919493686231051/523300790283272234/2018-12-14-194114.png
        # I want to point out, the symbol ※ is used as a Bullet Point Mark.
        # Example: https://i.imgur.com/Z6yQfbF.png
        
        # https://cdn.discordapp.com/attachments/235919493686231051/523030725616992267/2018-12-14-005011.png
        # 補給してよろしいですか？ - "Resupply with the following?" - this is more localized.
        # 必要燃料数 - "Fuel Required" - maybe "Needed"?
        # 必要弾薬数 - "Ammunition Required" - maybe "Needed". If after testing "Ammunition Required" does not fit well, switch to "Ammo Required". I would prefer to not be sloppy if we do not have to be though.
        
        # 接近            - "Approach"
        # 離脱            - "Escape" - Withdraw, Escape or Retreat
        # 航空攻撃         - "Aerial Attack" - Air Strike 
        # 砲撃            - "Shelling" - Bombard could work as well. 
        # 対潜攻撃         - "ASW" - Anti-submarine attack or Anti-submarine warfare(ASW)
        # 突撃（接近+砲撃） - "Assault (Approach + Shelling)" - Charge, increase accuracy while decreasing evasion
        # 雷撃            - "Torpedo" - can be opener and closer if ships have right equipment or are high-level subs
        # 回避            - "Evade" - no attack, Evasion
        # 統射            - "Coordinated Shelling" Tough one. It literally breaks down into Unified Archery. For now, I am going to go with Coordinated Shelling to see how it fits - Radar-coordinated Shelling
        #           ** I have updated these to reflect \resources\Textures\info6_set.tex.png ** these are final translations between 接近 and 統射
        
        # 制空権確保         - "Air Secured" - Air Supremacy or Air Superiority Ensured
        # 航空優勢          - "Air Advantage" - Air Superiority
        # 制空権喪失         - "Air Disadvantage" - Air Incapability or Air Superiority Lost
        
        # 装備数が保有上限に達し開発できません - "Equipment storage full, can not develop any more." warning message when constructing ships
        # 装備の保有上限に達しています        - "Equipment storage full." warning message when claiming ships
        # 艦が保有上限に達し建造できません     -  "Ship Girl storage full, can not construct any more." warning message when constructing ships
        
    );
}
