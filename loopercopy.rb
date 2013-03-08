#!/usr/bin/ruby1.8 -w
# Logger Example

require 'logger'
require 'thread'

XMAX = 20
YMAX = 20
LOG = Logger.new(STDOUT)
LOG.level = Logger::DEBUG


unless ARGV.length == 2
	LOG.FATAL( "Usage: SRC DEST")
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
				res = system("scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no #{ARGV[0]} root@node#{x}-#{y}:#{ARGV[1]} 2> /dev/null")
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

