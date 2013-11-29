require 'net/ping'

class Portscan
  def initialize(host = '127.0.0.1', ports = 1..65536)
    @host  = host
    @ports = ports
  end

  def do_ping
    ping = Net::Ping::External.new( @host )
    if ping.ping?
      puts "#{@host} is up. [ICMP]"
    else
      puts "#{@host} is down. [ICMP]"
    end
  end

  def do_portscan
    @ports.each { |p|
      ping_tcp = Net::Ping::TCP.new(@host, p, timeout = 5)
      puts "#{@host}\t[#{p}]" if ping_tcp.ping?
    }
  end
end
