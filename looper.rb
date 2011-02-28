#!/usr/bin/ruby1.8 -w
# Logger Example

require 'logger'

  log = Logger.new(STDOUT)
  log.level = Logger::DEBUG

  log.debug("Created logger")
  log.info("Program started")
  log.warn("Nothing to do!")

  begin
	  for x in 1..20
		  for y in 1..20
			 xdest = rand(10) + rand(10)
			 ydest = rand(10) + rand(10)
			 system("ssh root@node#{x}-#{y} ifconfig exp0 192.168.#{x}.#{y} netmask 255.255.0.0")
			 system("ssh root@node#{x}-#{y} ping 192.168.#{xdest}.#{ydest}")
		 end
	 end
  rescue => err
    log.fatal("Caught exception; exiting")
    log.fatal(err)
  end

