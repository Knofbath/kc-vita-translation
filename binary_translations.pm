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
    );
}
