#!/usr/bin/ruby1.8 -w

require 'logger'
require 'thread'


log = Logger.new(STDOUT)
log.level = Logger::DEBUG

begin
#	lock = Mutex.new
#	buf = Array.new
	threads=Array.new()
	1.upto(5){|i| threads.push(Thread.new{5.times{slp=1+rand(9);sleep(slp);log.info("#{i} happened, slept #{slp}")}})}
	threads.map{|t| t.join}
rescue => err
	log.fatal("Caught exception; exiting")
	log.fatal(err)
end

