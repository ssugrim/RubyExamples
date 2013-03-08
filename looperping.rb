#!/usr/bin/ruby1.8 -w
# Logger Example

require 'logger'
require 'thread'

XMIN = ARGV[0].to_i
YMIN = ARGV[1].to_i
XMAX = ARGV[2].to_i
YMAX = ARGV[3].to_i

LOG = Logger.new(STDOUT)
LOG.level = Logger::INFO


unless ARGV.length == 4
	LOG.fatal( "Usage: loopecmd.rv xmin ymin xmax ymax CMD")
	exit
end

LOCK = Mutex.new()
buffer = Array.new()
sucess = Array.new()
notsucess = Array.new()
threads = Array.new()

begin
	Range.new(XMIN,XMAX).map do |x|
		Range.new(YMIN,YMAX).map do |y|
			t = Thread.new do
				res = system("ping -c 1 node#{x}-#{y} > /dev/null")
				LOG.debug("Results was: #{res} for #{x},#{y}")
				LOCK.synchronize do
					sucess.push([x,y]) if res
					notsucess.push([x,y]) unless res
				end
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
	LOG.info("NOT Sucessfull nodes:[#{notsucess.map{|b|"[#{b[0]},#{b[1]}]"}.join(",")}]")
	LOG.info("Number of NOT sucesses: #{notsucess.length}")

end

