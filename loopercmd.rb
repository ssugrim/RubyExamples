#!/usr/bin/ruby1.8 -w
# Logger Example

require 'logger'
require 'thread'

XMAX = 1
YMAX = 2
LOG = Logger.new(STDOUT)
LOG.level = Logger::DEBUG


unless ARGV.length == 1
	LOG.FATAL( "Usage: looperun CMD")
	exit
end

LOCK = Mutex.new()
buffer = Array.new()
sucess = Array.new()
threads = Array.new()

begin
	for x in 1..XMAX
		for y in 1..YMAX
			t = Thread.new do
				tx = x
				ty = y
				res = system("ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@node#{tx}-#{ty} #{ARGV[0]} 2> /dev/null")
				LOG.debug("Results was: #{res} for #{tx},#{ty}")
				LOCK.synchronize {sucess.push([tx,ty]) if res}
			end
			threads.push(t)
		 end
	 end
	threads.map{|t| t.join}
rescue => err
	LOG.fatal("Caught exception; exiting")
	LOG.fatal(err)
ensure
	LOG.info("Sucessfull nodes:[#{sucess.map{|b|"[#{b[0]},#{b[1]}]"}.join(",")}]")
	LOG.info("Number of sucesses: #{sucess.length}")

end

