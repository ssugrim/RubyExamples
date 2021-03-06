#!/usr/bin/ruby -w
# Logger Example

require 'logger'
require 'thread'

XMIN = ARGV[0].to_i
YMIN = ARGV[1].to_i
XMAX = ARGV[2].to_i
YMAX = ARGV[3].to_i

LOG = Logger.new(STDOUT)
LOG.level = Logger::DEBUG


unless ARGV.length == 5
	LOG.fatal( "Usage: loopecmd.rv xmin ymin xmax ymax CMD")
	exit
end

LOCK = Mutex.new()
buffer = Array.new()
sucess = Array.new()
failures = Array.new()
threads = Array.new()

begin
	Range.new(XMIN,XMAX).map do |x|
		Range.new(YMIN,YMAX).map do |y|
			t = Thread.new do
				res = system("ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@node#{x}-#{y} #{ARGV[4]} 2> /dev/null")
				LOG.debug("Results was: #{res} for #{x},#{y}")
#				LOCK.synchronize {sucess.push([x,y]) if res}
				LOCK.synchronize {res ? sucess.push([x,y]) : failures.push([x,y])}
			end
			threads.push(t)
		 end
	 end
	threads.map{|t| t.join}
rescue => err
	LOG.fatal("Caught exception; exiting")
	LOG.fatal(err)
ensure
	LOG.info("Sucessfull nodes:[#{sucess.sort{|x,y| c = (x[0] <=> y[0]); c.zero? ? x[1] <=> y[1] : c }.map{|b|"[#{b[0]},#{b[1]}]"}.join("\n")}]")
	LOG.info("Number of sucesses: #{sucess.length}")
#	LOG.info("Failed nodes:[#{failures.map{|b|"[#{b[0]},#{b[1]}]"}.join(",")}]")
	LOG.info("Number of failures: #{failures.length}")

end

