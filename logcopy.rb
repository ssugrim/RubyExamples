#!/usr/bin/ruby1.8 -w
# Copies log files if there are any errors. version 0.04

require 'ftools'

#get hostname
$hostname = `/bin/hostname --fqdn`.split("\n")
#file I'm checking
$logfile = "/tmp/writer.log"
#dir to save to
$savedir = "/mnt/logs/"

if __FILE__ == $0

	try = 0

	begin
		#check for instaces of the word error
		try += 1
		raise "#{$logfile} not found" unless File.exist? $logfile
		found = (File.open($logfile).grep(/ERROR/))

		
		#temporarily ignoring the check, will just blindly copy. In the future I should copy only if errors occur
		if TRUE :
			#uses the File.basename method to extract the file name, and then tacks on the Node name
			newName = $hostname[0] + "-" + File.basename($logfile)

			#stagger the connection attempts
			sleep(rand(30))

			#mount Repo directory
			`mount repository1:/export/orbit/image/tmp /mnt`
	
			File.copy($logfile, $savedir + newName)
		else 
			raise 'Not Found'
		end
	rescue Exception => e
		puts "#{e.message}"
		sleep(30 + rand(30))
		retry if try < 4
		raise
	ensure
		sleep(30+ rand(30))
		`umount /mnt`
	end
end

