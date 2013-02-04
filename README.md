network_check - rubyで簡易ポートスキャン
=============

# 実行方法
引数にポートスキャン宛先リストを指定して実行する。引数がない場合は、./pinglist.txtをデフォルトで入力ファイルとみなす。

    $ ruby main_portscan.rb [file]

入力ファイルpinglist.txt(宛先IPアドレスリスト)は以下のような感じで改行区切り。宛先のIPアドレス[or 名前解決可能なホスト名]を列挙するだけ。

    192.168.0.1
    www.yahoo.co.jp
    192.168.0.25
    172.30.5.1

以下のように、同一セグメントの全ホストに対してportscan攻撃するのもありですね。

    for i in 1..254
      Portscan.new("192.168.0.#{i}", 1..65536).do_portscan
    end
