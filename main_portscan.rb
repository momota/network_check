$LOAD_PATH.push('.')
require 'yaml'
require 'lib/portscan'

input_file = ARGV[0] || "./input_files/pinglist.yml"
iplist = YAML.load_file( input_file )

iplist["hosts"].each { |host|
  p = Portscan.new(host, iplist["ports"])
  p.do_ping
  p.do_portscan
  puts "----------------------------------"
}
