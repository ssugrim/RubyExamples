#!/usr/bin/ruby1.8 -w

require 'logger'

log = Logger.new(STDOUT)
log.level = Logger::DEBUG

x = "Declared in parent"

begin
	for i in 1..50
		puts "Starting #{i}"
		pid =  fork {
			rnom = rand(6) + 1
			log.debug(" #{i} sleeping #{rnom}")
			sleep(rnom)
			log.debug("#{i} done, x was #{x}")
		}
		log.debug("Child forked at #{pid}")
	end
rescue => err
	log.fatal("Caught exception; exiting")
	log.fatal(err)
end

