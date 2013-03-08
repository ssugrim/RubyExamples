#!/usr/bin/ruby1.8 -w
# Logger Example

require 'logger'
require 'thread'

XMIN = ARGV[0].to_i
YMIN = ARGV[1].to_i
XMAX = ARGV[2].to_i
YMAX = ARGV[3].to_i

LOG = Logger.new(STDOUT)
LOG.level = Logger::INFO


unless ARGV.length == 4
	LOG.fatal( "Usage: looperifckeck.rb xmin ymin xmax ymax")
	exit
end

LOCK = Mutex.new()
buffer = Array.new()
gig = Array.new()
threads = Array.new()

begin
	Range.new(XMIN,XMAX).map do |x|
		Range.new(YMIN,YMAX).map do |y|
			t = Thread.new do
				`ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@node#{x}-#{y} apt-get update`
				`ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@node#{x}-#{y} apt-get install ethtool`
				`ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@node#{x}-#{y} ifconfig exp0 down 2> /dev/null`
				`ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@node#{x}-#{y} ifconfig exp0 192.168.#{x}.#{y} netmaks 255.255.0.0 2> /dev/null`
				`ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@node#{x}-#{y} ifconfig exp0 up 2> /dev/null`
				`ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@node#{x}-#{y} ifconfig eth0 down 2> /dev/null`
				`ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@node#{x}-#{y} ifconfig eth0 192.168.#{x}.#{y} netmaks 255.255.0.0 2> /dev/null`
				`ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@node#{x}-#{y} ifconfig eth0 up 2> /dev/null`
				sleep(10)
				res1 = `ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@node#{x}-#{y} ethtool exp0 2> /dev/null`.match(/Speed:\s(\d*)Mb/).to_a[1].to_i
				res2 = `ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@node#{x}-#{y} ethtool eth0 2> /dev/null`.match(/Speed:\s(\d*)Mb/).to_a[1].to_i
				res = res1.to_i + res2.to_i
				LOG.info("Results node#{x}-#{y}: #{res} #{res.class}")
				LOCK.synchronize do
					gig.push([x,y]) if res > 200 
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
	LOG.info("Sucessfull nodes:[#{gig.map{|b|"[#{b[0]},#{b[1]}]"}.join(",")}]")
	LOG.info("Number of giges: #{gig.length}")
end

