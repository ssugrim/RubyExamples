#!/usr/bin/ruby1.8 -w
# Logger Example

require 'logger'

  log = Logger.new(STDOUT)
  log.level = Logger::DEBUG

  log.debug("Created logger")
  log.info("Program started")
  log.warn("Nothing to do!")

  begin
    File.each_line(path) do |line|
      unless line =~ /^(\w+) = (.*)$/
        log.error("Line in wrong format: #{line}")
      end
    end
  rescue => err
    log.fatal("Caught exception; exiting")
    log.fatal(err)
  end

