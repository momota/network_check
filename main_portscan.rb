#!/usr/local/bin/ruby
require './portscan'

@iplist = ARGV[0] || "./pinglist.txt"
@ports = [
  'ftp',
  'ssh',
  'telnet',
  3389  # RDP
]

File::open( @iplist ) { |f|
  f.each { |line|
    Portscan.new(line.chomp, @ports).do_portscan
    puts "----------------------------"
  }
}
