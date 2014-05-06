#!/usr/bin/ruby1.8 -w

require 'logger'
require 'thread'

log = Logger.new(STDOUT)
log.level = Logger::DEBUG

begin
	for i in 1..50
		puts "Starting #{i}"
		t = Thread.new {
			rnom = rand(6) + 1
			log.debug("Thread #{i} sleeping #{rnom}")
			sleep(rnom)
			log.debug("Thread #{i} done")
		}
	end
	t.join
rescue => err
	log.fatal("Caught exception; exiting")
	log.fatal(err)
end

