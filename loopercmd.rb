#!/usr/bin/ruby1.8 -w
# Logger Example

require 'logger'
require 'thread'

XMAX = 20
YMAX = 20
LOG = Logger.new(STDOUT)
LOG.level = Logger::INFO


unless ARGV.length == 1
	LOG.FATAL( "Usage: looperun CMD")
	exit
end

LOCK = Mutex.new()
buffer = Array.new()
sucess = Array.new()
threads = Array.new()

begin
	Range.new(1,XMAX).map do |x|
		Range.new(1,YMAX).map do |y|
			t = Thread.new do
				res = system("ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@node#{x}-#{y} #{ARGV[0]} 2> /dev/null")
				LOG.debug("Results was: #{res} for #{x},#{y}")
				LOCK.synchronize {sucess.push([x,y]) if res}
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

