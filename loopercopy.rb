#!/usr/bin/ruby1.8 -w
# Logger Example

require 'logger'
require 'thread'

  log = Logger.new(STDOUT)
  log.level = Logger::DEBUG

  log.debug("Created logger")
  log.info("Program started")
  log.warn("Nothing to do!")

  begin
	  for x in 1..20
		  for y in 1..20
			Thread.new do
				system("scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no /home/ssugrim/scripts/pingtest/pingtest_node.rb root@node#{x}-#{y}:/usr/bin/pingtest_node.rb")
			end
		 end
	 end
  rescue => err
    log.fatal("Caught exception; exiting")
    log.fatal(err)
  end

