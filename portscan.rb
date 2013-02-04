require 'rubygems'
require 'ping'
require 'net/ping'

class Portscan
  def initialize(host = '127.0.0.1', ports = 1..65536)
    @host  = host
    @ports = ports
  end

  def do_ping
    puts "#{@host} is up. [ICMP]" if Ping.pingecho(@host, timeout = 5, service = 'echo')
  end

  def do_portscan
    @ports.each { |p|
      ping_tcp = Net::Ping::TCP.new(@host, p)
      puts "#{@host}\t[#{p}]" if ping_tcp.ping?
    }
  end
end
