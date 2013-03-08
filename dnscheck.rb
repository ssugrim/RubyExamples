#!/usr/bin/ruby1.8 -w

require 'logger'

LOG = Logger.new("/tmp/dnsout.txt")
LOG.level = Logger::INFO

while true do
	query = `dig @10.0.0.9 www.orbit-lab.org`
	LOG.info("#{query.match(/Query time:.*$/).to_a[0]}")
	LOG.info("#{query.match(/SERVER:.*$/).to_a[0]}")
	sleep(20)
	puts "slept 20"
end




