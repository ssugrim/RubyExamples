#!/usr/bin/ruby1.8 -w

require 'logger'
require 'thread'


log = Logger.new(STDOUT)
log.level = Logger::DEBUG

begin
	ip = "192.168.12.16A192.168.3.20A192.168.15.19A192.168.13.2A192.168.17.13A192.168.3.15A192.168.9.5A192.168.15.14A192.168.2.18A192.168.8.11A"
	puts ip.split("A")

rescue => err
	log.fatal("Caught exception; exiting")
	log.fatal(err)
end

