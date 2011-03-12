#!/usr/bin/ruby1.8 -w

require 'logger'
require 'thread'


log = Logger.new(STDOUT)
log.level = Logger::DEBUG

begin
	lock = Mutex.new
	buf = Array.new
	threads=Array.new()
#	1.upto(5){|i| threads.push(Thread.new{5.times{slp=1+rand(9);sleep(slp);log.info("#{i} happened, slept #{slp}")}})}
	1.upto(15) do |i|
		threads.push( Thread.new do 
				slp = 1 + rand(4)
				hld = 1 + rand(9)
				log.info("#{i} begins sleeping for #{slp}")
				sleep(slp)
				log.info("#{i} waiting on lock") if lock.locked?
				lock.synchronize do
					log.info("#{i} pushes")
					buf.push(i)
					log.info("#{i} holding the lock for #{hld}")
					sleep(slp)
				end
		end
			    )
	end
	threads.map{|t| t.join}
	puts buf
rescue => err
	log.fatal("Caught exception; exiting")
	log.fatal(err)
end

