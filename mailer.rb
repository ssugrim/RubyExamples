#!/usr/bin/ruby1.8 -w

require 'logger'
require 'action_mailer'


log = Logger.new(STDOUT)
log.level = Logger::DEBUG

begin
	ActionMailer::Base.smtp_settings = { 
		:address => 'smtp.orbit-lab.org',
		:port => 25,
		:domain => 'orbit-lab.org',
#		:user_name => 'user',
#		:password => 'pass',
#		:authentication => :login,
#		:enable_starttls_auto => true
	}

	class SimpleMailer < ActionMailer::Base
		def simple_message(msg)
			from 'ssugrim@orbit-lab.org'
			recipients 'ssugrim@winlab.rutgers.edu'
			subject 'Best engrish for you'
			body msg
		end
	end

	puts SimpleMailer.deliver_simple_message('Patatoes')
rescue => err
	log.fatal("Caught exception; exiting")
	log.fatal(err)
end

