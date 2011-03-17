#!/usr/bin/ruby1.8 -w

require 'logger'
require 'thread'


log = Logger.new(STDOUT)
log.level = Logger::DEBUG

begin
	lock = Mutex.new
	buf = Array.new
	nums = (1..150).to_a
	threads = nums.map do |i|
		Thread.new do
			slp = 1 + rand(2)
			hld = 1 + rand(3)
			log.info("#{i} begins sleeping for #{slp}")
			sleep(slp)
			log.info("#{i} waiting on lock") if lock.locked?
			lock.synchronize do
				log.info("#{i} pushes")
				buf.push(i)
				log.info("#{i} holding the lock for #{hld}")
				sleep(hld)
			end
		end
	end
	threads.map{|t| t.join}
	puts buf
rescue => err
	log.fatal("Caught exception; exiting")
	log.fatal(err)
end

