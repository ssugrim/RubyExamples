#!/usr/bin/ruby1.8 -w
# Logger Example

require 'logger'

log = Logger.new(STDOUT)
log.level = Logger::DEBUG

nodes = [[1,1],[1,2]]

begin
	nodes.each do |coord|
		system("ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@node#{coord[0]}-#{coord[1]} 'nohup /usr/bin/ruby /root/node_looper.rb </dev/null >>/tmp/foo.log &'")
	end
rescue => err
	log.fatal("Caught exception; exiting")
	log.fatal(err)
end

