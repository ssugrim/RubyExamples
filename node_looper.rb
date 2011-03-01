#!/usr/bin/ruby1.8 -w
# Logger Example

require 'logger'

  log = Logger.new(STDOUT)
  log.level = Logger::DEBUG

  a,x,y = `hostname`.match(/node(\d*)-(\d*)./).to_a
  puts "ifconfig exp0 192.168.#{x}.#{y} netmask 255.255.0.0"

#  begin
#	  for xd in 1..20
#		  for yd in 1..20
#			 system("ping 192.168.#{xd}.#{yd}")
#		 end
#	 end
 # rescue => err
  #  log.fatal("Caught exception; exiting")
   # log.fatal(err)
#  end

