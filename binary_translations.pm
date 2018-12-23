package binary_translations;
use strictures 2;
use utf8;

1;

sub data {
    return (
        "選択" => {
            tr   => "Select",
            desc => "explains numpad (the skips should be rechecked probably)",
            ok   => 'a-csharp 4562125',
            skip => [
                map "a-csharp $_", qw( 4487986 4495884 4539834 4539862 4539876 4539906 4548242 4548242 4548404 4550010 4550048 4550486 4552806
                  4562095 4562119 4495298 4563095 4563131 4563513 4564079 4566677 4570003 4595855 4595927 4596751 4596779
                  4596809 4596951 4598553 4598719 4598751 4633240 4698799 4698860 4698896 4699107 4699472 )
            ]
        },
        "提督コマンド" => {
            tr   => "Admiral Command",                                                       # quick menu?
            desc => "usually opens quick menu or changes the buttons to an alternate set, Arsenal.UIHowToArsenal",
            ok   => [ 'a-csharp 4518854', 'a-csharp 4682604' ]
        },
        "戦略へ" => {
            tr   => "Strategy",
            desc => "leads to fleet strategy management screen, Arsenal.UIHowToArsenal",
            ok   => [ 'level22/level22_00034.-4 196', 'sharedassets5/sharedassets5_00617.-4 196', 'a-csharp 4518868' ],
        },
        "決定" => { tr => "Choose", desc => "select the currently chosen option, Arsenal.UIHowToArsenal", ok => 'a-csharp 4518802' },
        "戻る" => { tr => "Back",   desc => "back out of the current screen, Arsenal.UIHowToArsenal",     ok => 'a-csharp 4518826', skip => [ 'a-csharp 4566833', 'a-csharp 4682617' ] },
        "戻る　　決定"             => { tr => "Back  Choose", },
        "選択　　戻る　　決定" => { tr => "Select  Back  Choose", },

        "作戦難易度を選択してください" => { tr => "Please select strategy difficulty level", },
        "タイトルに戻る"                      => { tr => "Back to Title", desc => "name choosing menu", ok => 'a-csharp 4566823' },
        "提督名入力" => { tr => "Admiral Name Entry", desc => "name choosing menu title, not sure if this one is used", ok => [ 'a-csharp 4566487', 'a-csharp 4699444' ] },

        "  貴官の提督名をお知らせ下さい。(" => { tr => "Please choose your Admiral's name. (Up to ", ok => 'a-csharp 4566537', desc => "TODO: verify the space at the start" },
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
        "チュートリアルを行いますか？" => {},

        "配備輸送船数" => { tr => "Transports",    desc => "Number of deployed shipping vessels, Cargo ships in area" },
        "予想獲得資源" => { tr => "Expected Gain", desc => "Expected acquisition resources (Daily Resource Generation) Fuel, Ammo, Steel, Bauxite per map hex" },
        "海上護衛艦隊" => { tr => "Escort fleet",  desc => "Maritime Escort Fleet", skip => [ 'a-csharp 4604319', 'a-csharp 4604361' ] },                           #  part of larger strings
        "回航中"          => { tr => "At Sea",        desc => "map screen, tankers at sea, apparently, but also used elsewhere" },
        "未配備"          => { tr => "Undeployed",    desc => "Undeployed - one char too long, really need to add glyph aliasing here too" },

        # 艦隊   状態   艦種   艦船名    Lv    耐久   火力   対空   速カ
        # ship table headers
        "艦隊"    => { tr => "Fleet",     desc => "Fleet Number. Defines which fleet the ship is assigned to. try with adding space at begin for formatting. further adjustements pending results." },
        "状態"    => { tr => "State",     desc => "Status/Condition of current fleet (red is has acted, blue is on expedition, blue is (maybe) 'on deployment', and blue is at sea again)" },
        "艦種"    => { tr => "Class",     desc => "Ship Class - maybe 'Hull'" },
        "艦船名" => { tr => "Ship Name", desc => 'prefer "Ship Name" over "name" - requires font substitution.' },
        # Lv - Obviously no need to translate
        "耐久" => {
            tr   => "Health",
            desc => 'Use Health for clarity as it is already used in other locations. is easier to use "Health" if we can resize it slightly than it would be for changing all the previous uses.'
        },
        "火力" => { tr => "ATK",   desc => "Firepower or ATK, I am still shying from FP or ATK though - Seriosuly this should be easy. The Kanji is literally Fire and Power" },
        "対空" => { tr => "AA",    desc => "Anti-air or Air Defense" },
        "速力" => { tr => "Speed", desc => "Try Speed instead of SPD as I would like to check table formatting." },

        "火力 -10" => {},

        #[1:06 AM] Knofbep: the damage shows up 2nd to last column
        #[1:06 AM] Knofbep: next to the heart lock
        # https://cdn.discordapp.com/attachments/235919493686231051/522193240510693396/2018-12-11-182050.png
        # https://cdn.discordapp.com/attachments/235919493686231051/522203328923435018/2017-05-02-221035.jpg

        # this.Title.text = monthName.Length != 2 ? "新しい月、　　　　となりました！" : "新しい月、　　　となりました！";
        "新しい月、　　　　となりました！" =>
          { tr => "A new month,　　　　, is here!", ok => 'a-csharp 4572711', desc => "the month is rendered as a separate string into the gap" },
        "新しい月、　　　となりました！" => { tr => "A new month,　　　, is here!", ok   => 'a-csharp 4572679', desc => "the month is rendered as a separate string into the gap" },
        "新しい週になりました！"             => { tr => "A new week is here!",             desc => "weekly resource bonus" },

        "ターンを終了しますか？" => { tr => "Do you want to end your turn?", desc => "Quick Turn End by hitting Square - performed on Operations Screen." },
        "ターン終了" => { tr => "End of Turn", desc => "Quick Turn End, hit Square to confirm", skip => [ 'a-csharp 4573257', 'a-csharp 4604171' ] },    # skips part of larger strings
        "[12c112]ターン終了[-]" => { tr => "[12c112]End of Turn[-]", desc => "Quick Turn End, hit Square to confirm" },

        # Enemy Raiding
        # these are embedded in sharedassets5/Atlas_RaderHukidashi.tex
        # 護衛艦損傷！        - Escort ship damage! #
        # 輸送船×1隻喪失！    - Transport ship x 1 lost!
        # 輸送船×13隻喪失！   - Transport ship x 13 lost!, example 2
        "護衛艦" => { tr => "Escort",    desc => "could use the word 'ship' in there, but too long, need font replacement" },
        "輸送船" => { tr => "Transport", desc => "could use the word 'ship' in there, but too long, need font replacement" },

        # Expedition completion screen (these are probably art)
        # 獲得ボーナス        - Acquisition bonus # can't find as text
        # 海域EXP            - Marine area EXP # can't find as text
        # （基本経験値）       -(Basic experience value) # only as part of a longer text in Assembly-CSharp\local\models\battle\BattleResultModel.cs
        "獲得アイテム" => { tr => "Earned items", desc => "followed by icons and numbers which don't need translation" },

        "敵艦隊"             => { desc => "" },

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
            ok   => [ 'a-csharp 4564133', 'a-csharp 4698584' ],         # i am VERY unsure about these hits, they'll require verification
            desc => q["Where do you want to go?" or " Where to now?", SortieMap.Defines]
        },

        # Battle formation screen
        "陣形を選択してください。" => { tr => "Please select the formation.", desc => "SortieMap.Defines", ok => [ 'a-csharp 4564073', 'a-csharp 4698793' ] },
        "単縦陣"                            => { tr => "Line Ahead",                   ok => 'a-csharp 4501426' },
        "複縦陣"                            => { tr => "Double Line",                  ok => 'a-csharp 4501434' },
        "輪形陣"                            => { tr => "Diamond",                      ok => 'a-csharp 4501442' },
        "梯形陣"                            => { tr => "Echelon",                      ok => 'a-csharp 4501450' },
        "単横陣" =>
          { tr => "Line\nAbreast", ok => 'a-csharp 4501458', desc => "these are all the accepted translations already. so yes. See if you can do a carriage return after Line ina all of these." },

        "獲得可能資材" => { tr => "Materials Available",      desc => '[OC] that means out of context and i reserve the right to edit later.' },
        "残り輸送船数" => { tr => "Ships Remaining",          desc => '[OC]' },
        "必要輸送船数" => { tr => "Required Number of Ships", desc => '[OC]', skip => 'a-csharp 4603172', },                                       # part of a larger string

        # Compass fairy with magic hat
        # https://cdn.discordapp.com/attachments/235919493686231051/523259704890097675/2018-12-05-071704.png
        "らしんばんをまわしてね！" => {
            tr   => "Spin the compass please!",
            ok   => 'a-csharp 4564621',
            desc => "a compass fairy text. these are in csharp, but the decompiler doesn't see them. maybe these could default to a cute way of speaking?"
        },
        # Compass fairy with bob haircut
        # https://cdn.discordapp.com/attachments/235919493686231051/523259707331313713/2018-12-05-102944.png
        "ここっ"                                     => { tr => "Here!",                           desc => 'but with exertion', ok => 'a-csharp 4564761' },
        "よーし、らしんばんまわすよー！" => { tr => "Alright, I'll spin the compass!", ok   => 'a-csharp 4564557' },
        "えいっ"                                     => {
            tr   => "Ey!",
            ok   => 'a-csharp 4564647',
            desc => ''
              . q[it is a sound uttered/made when someone is exerting force, or throwing something. you would be best ignoring the "っ" for now. It is not a tsu. "つ" is. I am nt reallt set to explain sokuon and glottal stops.]
        },
        "それっ" => {
            tr   => "Take that!",
            ok   => 'a-csharp 4564655',
            desc => q["Take That!" or "That!" - can also use "This". remember implied words. once more with the っ. (i think it could also be "There!")]
        },
        # Compass fairy with chick on head
        # https://cdn.discordapp.com/attachments/235919493686231051/523259713480163328/2018-12-13-232523.png
        "はやくはやくー！" =>
          { tr => "Hurry! Hurry!", desc => q[i may localize it a little better. "C'mon! Hurry up!" alternate, more localized. Kind of like it myself.], ok => 'a-csharp 4564539' },
        "えいえいえーいっ" => {
            tr   => "Here!\x{200B}\x{200B}\x{200B}",
            desc => 'I need to see it in use for flavour. Knofbath translation does not feel right at this time. since the tr was VERY short i added zero width spaces',
            ok   => 'a-csharp 4564885'
        },
        "とまれーっ" => { tr => "And Another One", desc => 'i will come back to this one. more context needed.', ok => 'a-csharp 4565001' },
        # Compass fairy who is sleepy
        # https://cdn.discordapp.com/attachments/235919493686231051/523259716009328658/2018-12-14-010022.png
        "えー？らしんばん、まわすのー？" => {
            tr   => "Uh? You want me to spin the compass?",
            desc => 'or "Spin The Compass Please" - this is extremely localized. for a more literal use, "What? Spin the compass." or maybe, "What? Spin The Compass Already."',
            ok   => 'a-csharp 4564589'
        },
        # https://cdn.discordapp.com/attachments/235919493686231051/523021829737283585/2018-12-14-010344.png
        "……ん" =>
          { tr => "...un!", desc => 'grunt like sound - [Previous is Depriciated - and context matters : "Huh?" -  Literally "....n." - Maybe use "Wha?" [t intentioanlly omitted]]', ok => 'a-csharp 4564867' },
        # https://cdn.discordapp.com/attachments/235919493686231051/523021901270876172/2018-12-14-010056.png
        "……あい" => { tr => "...huhn", desc => 'Literally "...ai" - Or, maybe she is just making a sound. I am going to play with this some.', ok => 'a-csharp 4564875' },

        "この艦隊で出撃しますか？" => { tr => "Sortie this fleet?", ok => [ 'a-csharp 4567317', 'sharedassets5/sharedassets5_00551.-4 196', 'level4/level4_00309.-15 196' ] },
        "※艦娘保有数が上限に近いため、新しい艦娘と邂逅できない可能性があります。" =>
          { tr => "※If you have too many Ship Girls, there is a possibility of not getting a Ship Girl reward.", desc => 'Edited for consistency.', ok => "a-csharp 4567477" },
        "※艦娘保有数が上限に達しているため、新しい艦娘との邂逅はできません。" =>
          { tr => "※You have reached your limit of Ship Girls and can not accept your reward.", desc => 'red, ships full', ok => 'a-csharp 4567407' },

        # https://cdn.discordapp.com/attachments/235919493686231051/523300790283272234/2018-12-14-194114.png
        # I want to point out, the symbol ※ is used as a Bullet Point Mark.
        # Example: https://i.imgur.com/Z6yQfbF.png

        # https://cdn.discordapp.com/attachments/235919493686231051/523030725616992267/2018-12-14-005011.png
        "補給してよろしいですか？" => { tr => "Resupply with the following?", desc => 'this is more localized.', ok => 'sharedassets5/sharedassets5_01265.-4 196' },
        "必要燃料数"                      => { tr => "Fuel Required",                desc => 'maybe "Needed"?' },
        "必要弾薬数"                      => {
            tr   => "Ammunition Required",
            desc => 'maybe "Needed". If after testing "Ammunition Required" does not fit well, switch to "Ammo Required". I would prefer to not be sloppy if we do not have to be though.'
        },

        "接近"                    => { tr => "Approach" },
        "離脱"                    => { tr => "Escape", desc => 'Withdraw, Escape or Retreat' },
        "航空攻撃"              => { tr => "Aerial Attack", desc => 'Air Strike' },
        "砲撃"                    => { tr => "Shelling", desc => 'Bombard could work as well. ' },
        "対潜攻撃"              => { tr => "ASW\x{200B}", desc => 'Anti-submarine attack or Anti-submarine warfare(ASW)' },
        "突撃（接近+砲撃）" => { tr => "Assault (Approach + Shelling)", desc => 'Charge, increase accuracy while decreasing evasion' },
        "雷撃"                    => { tr => "Torpedo", desc => 'can be opener and closer if ships have right equipment or are high-level subs' },
        "回避"                    => { tr => "Evade", desc => 'no attack, Evasion' },
        "統射" => {
            tr   => "Coordinated Shelling",
            desc => 'Tough one. It literally breaks down into Unified Archery. For now, I am going to go with Coordinated Shelling to see how it fits - Radar-coordinated Shelling'
        },
        #           ** I have updated these to reflect \resources\Textures\info6_set.tex.png ** these are final translations between 接近 and 統射

        "制空権確保" => { tr => "Air Secured",      desc => 'Air Supremacy or Air Superiority Ensured' },
        "航空優勢"    => { tr => "Air Advantage",    desc => 'Air Superiority' },
        "制空権喪失" => { tr => "Air Disadvantage", desc => 'Air Incapability or Air Superiority Lost' },

        "装備数が保有上限に達し開発できません" =>
          { tr => "Equipment storage full, can not develop any more.", desc => 'warning message when constructing ships', ok => 'a-csharp 4501118' },
        "装備の保有上限に達しています" => { tr => "Equipment storage full.", desc => 'warning message when claiming ships', ok => 'a-csharp 4501184' },
        "艦が保有上限に達し建造できません" =>
          { tr => "Ship Girl storage full, can not construct any more.", desc => 'warning message when constructing ships', ok => 'a-csharp 4501084' },

        #"ボタンで戦略コマンド\nを開き、艦隊出撃せよ！",

        "旗艦提督室"                                   => { desc => 'flagship admirals  | map screen tutorial' },
        "への移動"                                      => { desc => 'map screen tutorial' },
        "[E2E2E2][12c112]旗艦提督室[-]への移動[-]" => { desc => 'flagship admirals |map screen tutorial' },
        "ボタンで"                                      => { desc => 'map screen tutorial' },
        "      ボタンで\n旗艦提督室へ移動せよ！" =>
          { desc => 'map screen tutorial', ok => 'resources/resources_00997.-10 196' },
        "戦略コマンド"         => { desc => 'Command|map screen circle' },
        "艦隊情報"               => { desc => 'Information|map screen triangle' },
        "艦隊選択"               => { desc => 'Selection|map screen left right d-pad', ok => 'level19/level19_00052.-4 196' },
        "海域選択"               => { desc => 'Selection|map screen right stick' },
        "艦隊旗艦"               => { desc => 'Fleet|map screen fleet name' },
        "○○○○艦隊旗艦\n" => { desc => 'Fleet |map screen fleet name, no idea if the circles can be touched' },

        # "第1艦隊旗艦" => { desc => 'map screen fleet name, the first char is gonna be a bit tricky to identify, leaving as is for now' },
        "[E2E2E2]はじめての[12c112]任務[-]！[-]" => { desc => 'admiral room tutorial for factory' },
        "[e2e2e2]はじめての[12c112]配備[-][-]" =>
          { desc => 'tutorial text found via text matching, the achievements indicate this should have an exclamation mark' },
        "[E2E2E2]はじめての[12c112]建造[-]！[-]" => { desc => 'tutorial text found via text matching' },
        "任務を受託せよ！"                    => { desc => 'admiral room tutorial for factory', ok => 'resources/resources_00790.-10 196' },
        "新規に       任務を受託可能です" => { desc => 'quests' },
        "任務内容確認"                          => { desc => 'quests' },
        "設定"                                      => { desc => 'settings', ok => 'a-csharp 4851256' },
        "操作ガイド"                             => { desc => 'settings' },
        "残り"                                      => { desc => 'factory time cost' },
        "日数"                                      => { desc => 'factory time cost' },
        "残り日数"                                => { desc => 'factory time cost' },
        "ロック"                                   => { desc => 'ship list', ok => 'a-csharp 4532088' },
        "ソート"                                   => { desc => 'ship list', ok => 'a-csharp 4519060' },

        "高速建造"                          => { desc => 'High speed construction | factory tutorial' },
        "[E2E2E2][12c112]高速建造[-]！[-]" => { desc => 'High speed construction | factory tutorial' },

        # [000000][006400]高速建造[-]について[-]

        "高速建造材を使い、\n建造を完了せよ！" => {
            desc => 'High speed construction | factory tutorial',
            ok   => [ 'resources/resources_00988.-10 196', 'resources/resources_01361.-10 196' ]
        },

        "達成" => { desc => "this little segment follows all achievements, having the script search for it will highlight those in the output" },

        "「はじめての建造！」 達成"    => { ok => 'a-csharp 4518268' },
        "「はじめての任務！」 達成"    => { ok => 'a-csharp 4524440' },
        "「はじめての配備！」 達成"    => { ok => 'a-csharp 4567769' },
        "「高速建造！」 達成"             => { desc => "High speed construction | ", ok => 'a-csharp 4518296' },
        "「任務完了！」 達成"             => { ok => 'a-csharp 4524330' },
        "「艦隊を編成！」 達成"          => { ok => 'a-csharp 4529846' },
        "「旗艦提督室への移動」 達成" => { ok => 'a-csharp 4533878' },
        "「作戦海域への出撃！」 達成" => { ok => 'a-csharp 4573639' },
        "「ターン終了」 達成"             => { ok => 'a-csharp 4573255' },

        "旗艦提督室で\n任務達成を\r確認せよ！\n"                                                => { },
        "[000000][0055aa]戦略ポイント[-]は、任務達成及び\n海域攻略などで手に入ります。\n\n[0055aa]工廠[-]での輸送船建造や、\r\n[0055aa]アイテム屋さん[-]でのアイテム購入で\n使用します。" => {},
        "[000000]敵反攻迎撃戦は、[0055aa]連合艦隊[-]で出撃可能です。\n[0055aa]連合艦隊[-]は、\r\n・前衛主力艦隊\r\n・決戦主力艦隊\nの二艦隊で編成されます。\n\nさらに艦隊が居る場合は、\rそれぞれに\n[115511]支援艦隊[-]を向かわせることが可能です。\r\n" => {},

        "被弾回避率補正" => {  ok => 'a-csharp 4556831' },
        "攻撃命中率補正" => { ok => 'a-csharp 4556815'},
        "雷撃命中率補正" => {  ok => 'a-csharp 4556847' },
        "海上護衛艦隊の対潜/対空能力:{0}" => { desc => "not in the source code?", ok => 'a-csharp 4604319' },
        "海上護衛艦隊(MemId:{0})は{1}のダメージ({2})" => {ok => 'a-csharp 4604361' },
        "海上護衛艦隊名海上護衛艦隊名" => { },
        "[000000][0055aa]海上護衛艦隊[-]の配備について" => { },

        "廃棄は □ボタンで行います" => {ok => 'a-csharp 4517038', desc => "Arsenal.TaskArsenalListManager"},
        "解体は □ボタンで行います" => {ok => 'a-csharp 4517066', desc => "Arsenal.TaskArsenalListManager"},
        "[000000]鎮守府海域から離れた海域であるほど、\n[0055aa]回航[-]にかかる日数（ターン数）は多くなります。\r\n\n鎮守府海域以外の輸送船団や海上護衛艦隊への\r\n配備を解除した場合も、同じく回航状態となり\nます。" => {},
        "[000000][0055AA]高速建造材[-]を保有している場合、\r\n同投入で[006400]高速建造[-]が可能です。\r\n\n艦娘の建造は、それが大型艦であるほど\r\n建造日数が掛かりますが、[0055aa]高速建造材[-]を\r\n用いることで、これを一瞬に短縮するこ\nとが\r可能です。\r\n[-]" => {},
        "[000000]作戦海域への出撃時に、マップ上で [006400]Lボタン[-]\n切り替え\rによって、戦闘演出をカットして\n戦闘時間を短縮する\r[0055aa]戦闘ショートカット[-]が\n可能です。\n\n出撃&戦闘\rに慣れてきたら、ご活用ください。\nただし、未攻略海域の最深部、敵主力艦隊\nとの交戦は、戦闘ショートカットできません。[-]" =>{ok=>'resources/resources_01570.-10 196'},
        "海域の輸送船団に海上護衛艦隊を配備することで、\r\n敵通商破壊部隊から輸送船を護ることが可能です。\n\nまた、輸送船団の規模に対して十分な護衛艦艇を\r\n配備することで、より安定した船団護衛が可能\nです。" => {},
        "未配備の輸送船数:{0}(この海域への移動中:{1}) - 総数:{2}" => { ok => 'a-csharp 4595279' },
        "輸送船 x {0}" => {ok => 'a-csharp 4489180'},
        "ロック済艦娘を" => {},
        "艦隊司令部情報" => {},
        "艦隊切替" => {},
        "艦隊数" => {},
        "　ボタンで戦略コマンド\nを開き、艦隊出撃せよ！" => {},
        "[000000][0055aa]輸送船[-]の配備について" => {},
        "[66ccff]全艦種出撃可能[-]です。"=>{},
        "ボタンで戦略コマンドを\n開き、ターンを終了せよ！"=>{ok=> 'resources/resources_01107.-10 199'},

        "Inspectorで設定して使用します。"                                                                                  => { desc => "not used in game, silences the scanner", ok => 'a-csharp 4847047' },
        "Inspector上でイベントを設定する為に使用するのでスクリプトないでは使用しないでください" => { desc => "not used in game, silences the scanner", ok => 'a-csharp 4847289' },
        "Inspector上でボタンに設定する為に使用します"                                                                => { desc => "not used in game, silences the scanner", ok => 'a-csharp 4846701' },
        "Inspector上で使用します。"                                                                                           => { desc => "not used in game, silences the scanner", ok => 'a-csharp 4847198' },
        "Inspector上で使用します"                                                                                              => { desc => "not used in game, silences the scanner", ok => 'a-csharp 4855717' },
        "Inspector上で使用するメソッドです"                                                                               => { desc => "not used in game, silences the scanner", ok => 'a-csharp 4847237' },
        "Inspector上で設定して使用したい...."                                                                              => { desc => "not used in game, silences the scanner", ok => 'a-csharp 4847146' },
        "Inspector上で設定して使用します。"                                                                               => { desc => "not used in game, silences the scanner", ok => 'a-csharp 4844461' },
        "Inspector上で設定して使用します"                                                                                  => { desc => "not used in game, silences the scanner", ok => 'a-csharp 4844533' },
        "Inspector上で選択して使用します."                                                                                 => { desc => "not used in game, silences the scanner", ok => 'a-csharp 4844581' },
        "Inspector上に設定して使用します"                                                                                  => { desc => "not used in game, silences the scanner", ok => 'a-csharp 4847418' },

        "艦隊は遠征中です"=>{ desc => "UIShortCutMenu", ok => 'a-csharp 4495756'},
        "艦隊を編成する必要があります"=>{desc => "UIPortFrame, UIShortCutMenu", ok => 'a-csharp 4495810'},
        "撤退中の艦が含まれています"=>{ desc => "UIShortCutMenu", ok => 'a-csharp 4495840'},
        "鎮守府海域でのみ選択可能です"=>{ desc => "UIShortCutMenu", ok => 'a-csharp 4495868'},
        "旗艦が工作艦である必要があります"=>{ desc => "UIShortCutMenu", ok => 'a-csharp 4495898'},
        "決戦！ショートカット不可"=>{ desc => "UIShortCutSwitch", ok => 'a-csharp 4496090'},
        "戦闘ショートカット"=>{ desc => "UIShortCutSwitch", ok => 'a-csharp 4496070'},
        "開発資材のインデックスが不正です"=>{ desc => "Arsenal.Arsenal_DevKit", ok => 'a-csharp 4610075' },
        "戦略ポイントのインデックスが不正です"=>{ desc => "Arsenal.Arsenal_SPoint", ok => 'a-csharp 4610109' },
        "輸送船を"=>{ desc => "Arsenal.ArsenalTankerDialog"                 },
        "隻入手しました"=>{ desc => "Arsenal.ArsenalTankerDialog"              },
        "艦がロックされています"=>{desc => "Arsenal.TaskArsenalListManager", ok => 'a-csharp 4517094'},
        "ロックされている装備があります"=>{desc => "Arsenal.TaskArsenalListManager", ok => 'a-csharp 4517118'},
        "建造"=>{desc => ".Arsenal.TaskConstructManager",},
        "大型建造"=>{desc => ".Arsenal.TaskConstructManager", ok => 'a-csharp 4517764'},
        "開発"=>{desc => ".Arsenal.TaskConstructManager",},
        "輸送船建造"=>{desc => ".Arsenal.TaskConstructManager",},
        "戦略ポイントが不足しています"=>{desc => ".Arsenal.TaskConstructManager", ok => 'a-csharp 4518318'},
        "解体  艦種  艦名　　　　　      Lv"=>{desc => "Arsenal.TaskMainArsenalManager", ok => 'a-csharp 4518706'},
        "廃棄      装備名　　　　　　　　　 レア"=>{desc => "Arsenal.TaskMainArsenalManager", ok => 'a-csharp 4518754'},
        "燃料"=>{desc => "Arsenal.UiArsenalMaterialDialog",},
        "弾薬"=>{desc => "Arsenal.UiArsenalMaterialDialog",},
        "鋼材"=>{desc => "Arsenal.UiArsenalMaterialDialog",},
        "ボーキサイト"=>{desc => "Arsenal.UiArsenalMaterialDialog",},
        "高速建造材"=>{desc => "Arsenal.UIHowToArsenal",},
        "随伴艦の"=>{desc => "Battle.Production.ProdEscortShipEvacuation", ok => 'a-csharp 4557329'},
        "を護衛につけて戦場から退避させますか？"=>{desc => "Battle.Production.ProdEscortShipEvacuation", ok => 'a-csharp 4557339'},
        "『{0}』艦隊<br>旗艦「{1}」が<br>大破しました。"=>{desc => "Battle.Production.ProdFlagshipWreck", ok => ['a-csharp 4557605', 'a-csharp 4698449']},
        "進撃は困難です……帰投します。"=>{desc => "Battle.Production.ProdFlagshipWreck", ok => ['a-csharp 4557685', 'a-csharp 4698510']},
        "敵反攻作戦 迎撃成功!!"=>{desc => "Battle.Production.ProdThalassocracy", ok => 'a-csharp 4558267'},
        "「{0}」リクエスト中♪"=>{desc => "Furniture.JukeBox.UIJukeBoxMusicPlayingDialog", ok => 'a-csharp 4532096'},
        "家具コインが不足しています"=>{desc => "Furniture.JukeBox.UserInterfaceJukeBoxManager", ok => 'a-csharp 4532184'},
        "購入 - {0} - "=>{desc => "InteriorStore.UIFurniturePurchaseDialog", ok => 'a-csharp 4525706'},
        "不要"=>{desc => "InteriorStore.UIFurniturePurchaseDialog", ok => 'a-csharp 4525736'},
        "必要"=>{desc => "InteriorStore.UIFurniturePurchaseDialog",},
        "給糧艦「間宮」を使用しますか？"=>{desc => "Organize.OrganizeTender", ok => 'a-csharp 4529162'},
        "給糧艦「伊良湖」を使用しますか？"=>{desc => "Organize.OrganizeTender", ok => 'a-csharp 4529302'},
        "艦隊名を入力してください。（12文字まで）"=>{desc => "Organize.TaskOrganizeTop", ok => 'a-csharp 4532034'},
        "「"=>{desc => "Production.ProdBattleRewardItem",},
        "」を" =>{desc => "Production.ProdBattleRewardItem",},
        "入手しました。"=>{desc => "Production.ProdBattleRewardItem", ok => 'a-csharp 4492312'},
        "」を入手しました。" =>{desc => "Production.ProdBattleRewardItem", ok => 'a-csharp 4492328'},
        " 装備の開発に失敗しました。\n\n『開発資材』は消費しませんでした。" =>{desc => "Production.ProdReceiveSlotItem", ok => 'a-csharp 4492850'},
        "部隊再編中…"=>{desc => "Production.ProdRevampReceiveItem", ok => 'a-csharp 4493086'},
        "装備改修中…"=>{desc => "Production.ProdRevampReceiveItem", ok => 'a-csharp 4493100'},
        "{0}に装備が改修更新されました！"=>{desc => "Production.ProdRevampReceiveItem", ok => 'a-csharp 4493138'},
        "{0}に部隊再編完了！"=>{desc => "Production.ProdRevampReceiveItem", ok => 'a-csharp 4493114'},
        "艦が保有上限に達しています" =>{desc => "Scene.Duty.UserInterfaceDutyManager", ok => 'a-csharp 4524382'},
        "装備が保有上限に達しています"=>{desc => "Scene.Duty.UserInterfaceDutyManager", ok => 'a-csharp 4524410'},
        "該当装備がロックされています" =>{desc => "Scene.Duty.UserInterfaceDutyManager", ok => 'a-csharp 4524352'},
        "撤退中の艦を含んでいます"=>{desc => "Strategy.DeckStateViews", ok => 'a-csharp 4567087'},
        "補給対象の艦が居ません" =>{desc => "Strategy.DeckStateViews", ok => 'a-csharp 4567113'},
        "資源が不足しています"  =>{desc => "Strategy.DeckStateViews", ok => 'a-csharp 4567137'},
        "撤退中の艦は入渠出来ません"=>{desc => "Strategy.DeckStateViews", ok => 'a-csharp 4567159'},
        "高速修復材を持っていません" =>{desc => "Strategy.DeckStateViews", ok => 'a-csharp 4567187'},
        "この海域には入渠ドックがありません"=>{desc => "UIShortCutMenu, Strategy.DeckStateViews", ok => 'a-csharp 4495932'},
        "入渠ドックに空きがありません"  =>{desc => "Strategy.DeckStateViews", ok => 'a-csharp 4567215'},
        "艦隊の前方にうずしおが発生しました！"=>{desc => "SortieMap.Defines", ok => ['a-csharp 4563245', 'a-csharp 4698597']},
        "{0}x{1}\nを入手しました！"=>{desc => "SortieMap.Defines", ok => [ 'a-csharp 4563211', 'a-csharp 4698634']},
        "{0}x{1}を\n落としてしまいました…。"=>{desc => "SortieMap.Defines", ok => ['a-csharp 4563367','a-csharp 4698667']},
        "{0}x{1}を\n落としてしまいました…。\n(電探が役立って、被害を抑えられた！)"=>{desc => "SortieMap.Defines", ok => ['a-csharp 4563283','a-csharp 4698710',]},
        "気のせいだった。"=>{desc => "SortieMap.Defines",},
        "敵影を見ず。"=>{desc => "SortieMap.Defines",},
        "艦隊の針路を選択できます。\n提督、どちらの針路を選択しますか？"=>{tr=>"Plot the fleet's course.\nAdmiral, pick a course?",desc => "SortieMap.Defines | could be 'Admiral, which course do you prefer?'", ok => ['a-csharp 4563083', 'a-csharp 4698848']},
        "水上偵察機による\n航空偵察を実施します。"=>{desc => "SortieMap.Defines", ok => ['a-csharp 4565165', 'a-csharp 4698911']},
        "大型飛行艇による\n航空偵察を実施します。"=>{desc => "SortieMap.Defines", ok => ['a-csharp 4565123', 'a-csharp 4698952']},
        "航空偵察予定地点に到着しましたが、\n稼働偵察機がないため、偵察を中止します。"=>{desc => "SortieMap.Defines", ok => ['a-csharp 4565045', 'a-csharp 4698993']},
        "艦隊に洋上補給を行います。"=>{desc => "SortieMap.Defines", ok => ['a-csharp 4563903', 'a-csharp 4699070']},
        "艦隊針路\n選択可能!"=>{desc => "SortieMap.Defines", ok => ['a-csharp 4563503', 'a-csharp 4699097']},

        "廃棄      装備名　　　　　　　　　 レア度"=>{},
        "この海域には入渠ドックがありません。" => {},
        "[000000][006400]戦闘ショートカット[-]について[-]"=>{},
		"輸送船を1隻入手しました"=>{},
		"戦略コマンドから配備を\n選択し、輸送船や海上護衛\n艦隊を配備せよ！"=>{},
    );
}
