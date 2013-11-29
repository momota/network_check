network_check - rubyで簡易ポートスキャン
========================================

# 環境

動作確認した環境は Ubuntu, Ruby 2.0.0p247。


# 準備

## rbenv で Ruby 2.0 に指定する。

```sh
$ rbenv install 2.0.0-p247
$ rbenv local 2.0.0-p247
$ rbenv rehash
$ rbenv version
2.0.0-p247 (set by /home/momota/dev/ruby/network_check/.ruby-version)
$ ruby -v
ruby 2.0.0p247 (2013-06-27 revision 41674) [x86_64-linux]
```

## bundler で net-ping をインストールする

```sh
$ gem install bundler
Successfully installed bundler-1.3.5
Parsing documentation for bundler-1.3.5
1 gem installed
$ bundle -v
Bundler version 1.3.5
$ bundle init
Writing new Gemfile to /home/momota/dev/ruby/network_check/Gemfile
$ cat << EOF >> ./Gemfile
heredoc> gem "net-ping", "~> 1.7.1"
heredoc> EOF
$ bundle install --path vendor/bundle
Fetching gem metadata from https://rubygems.org/..........
Fetching gem metadata from https://rubygems.org/..
Resolving dependencies...
Installing ffi (1.9.3)
Installing net-ping (1.7.1)
Using bundler (1.3.5)
Your bundle is complete!
It was installed into ./vendor/bundle
```

# 入力ファイル形式

入力ファイルpinglist.yml(宛先IPアドレスリスト)は以下のとおり。
`hosts` 項目に宛先のIPアドレス[or 名前解決可能なホスト名]を列挙する。
`ports` 項目にスキャン対象のTCPポートを列挙する。

```yaml
hosts:
  - 192.168.0.1
  - www.yahoo.co.jp
  - 192.168.0.25
  - 172.30.5.1
ports:
  - 20
  - 21
  - ssh
  - http
  - telnet
  - 3389  # RDP
```


# 実行方法

引数にポートスキャン宛先リストを指定して実行する。引数がない場合は、`./input_files/pinglist.tml`をデフォルトで入力ファイルとみなす。

```sh
$ bundle exec ruby main_portscan.rb [file]
192.168.0.186 is up. [ICMP]
192.168.0.186   [20]
192.168.0.186   [21]
192.168.0.186   [ssh]
192.168.0.186   [http]
192.168.0.186   [telnet]
192.168.0.186   [3389]
----------------------------------
192.168.0.187 is up. [ICMP]
192.168.0.187   [20]
192.168.0.187   [21]
192.168.0.187   [ssh]
192.168.0.187   [http]
192.168.0.187   [telnet]
192.168.0.187   [3389]
----------------------------------
192.168.0.188 is up. [ICMP]
192.168.0.188   [20]
192.168.0.188   [21]
192.168.0.188   [ssh]
192.168.0.188   [http]
192.168.0.188   [telnet]
192.168.0.188   [3389]
----------------------------------
.
.
.

```



以下のように、同一セグメントの全ホストに対してportscan攻撃するのもありですね。

```ruby
for i in 1..254
  Portscan.new("192.168.0.#{i}", 1..65536).do_portscan
end
```
