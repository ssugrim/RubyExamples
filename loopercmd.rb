#!/usr/bin/ruby1.8 -w
# Logger Example

require 'logger'
require 'thread'
require 'open3'

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
	for x in 1..20
		for y in 1..20
			t = Thread.new do
				sleep(1+rand(19))
				i,o,e,t = Open3.popen3("ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@node#{x}-#{y} #{ARGV[0]}")
				obuff = Array.new()
				e.each do |el|
					if el.match(/added/)
						o.each{|ol| obuff.push(ol)}
						LOCK.synchronize do
							buffer.push(obuff.join("\n"))
							sucess.push([x,y])
						end
					end
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
	LOG.info("Sucessfull nodes:#{sucess.map{|a| a.to_s + ","}}")
	LOG.info("Number of sucesses: #{sucess.length}")

end

