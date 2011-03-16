#!/usr/bin/ruby1.8 -w
# Logger Example

require 'logger'
require 'thread'

LOG = Logger.new(STDOUT)
LOG.level = Logger::DEBUG


unless ARGV.length == 1
	LOG.FATAL( "Usage: looperun CMD")
	exit
end

begin
	for x in 1..20
		for y in 1..20
			Thread.new do
				system("ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@node#{x}-#{y} #{ARGV[0]}")
			end
		 end
	 end
rescue => err
	log.fatal("Caught exception; exiting")
	log.fatal(err)
end

