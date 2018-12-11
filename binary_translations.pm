package binary_translations;
use strictures 2;

1;

sub data {
    return (
        "選択"                                     => { tr => "Select",                                  desc => "explains numpad", },
        "提督コマンド"                         => { tr => "Admiral Cmd",                             desc => "", },
        "戦略へ"                                  => { tr => "Strategy",                                desc => "", },
        "戦略へ	"                                 => { tr => "Strategy",                                desc => "", },
        "決定"                                     => { tr => "Choose",                                  desc => "" },
        "戻る"                                     => { tr => "Return",                                  desc => "" },
        "戻る　　決定"                         => { tr => "Return  Choose",                          desc => "", },
        "選択　　戻る　　決定"             => { tr => "Select  Return  Choose",                  desc => "", },
        "作戦難易度を選択してください" => { tr => "Please select strategy difficulty level", desc => "", },
        "提督名入力"                            => { tr => "Admiral Name",                            desc => "(this had to be shortened)", },

        "貴官の提督名をお知らせ下さい。\n（１２文字まで入力可能です）" => {
            tr   => "Please choose your Admiral's name.\n(Up to 12 characters can be entered.)",
            desc => "",
            ok   => 'level5/level5_00004.-6 196'
        },
    );
}
