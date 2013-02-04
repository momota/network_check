require 'rubygems'
require 'net/ping'

class Portscan
  def initialize(ip = '127.0.0.1', ports = 1..65536)
    @ip    = ip
    @ports = ports
  end

  def do_portscan
    @ports.each { |p|
      ping_tcp = Net::Ping::TCP.new(@ip, p)
      if ping_tcp.ping?
        puts "#{@ip} [#{p}]\t: o"
      else
        puts "#{@ip} [#{p}]\t: x"
      end
    }
  end
end
