#!/usr/bin/ruby1.8 -w
# Logger Example

require 'logger'

log = Logger.new(STDOUT)
log.level = Logger::DEBUG

nodes = [[19,12],[17,16],[13,18],[12,15],[12,10],[19,2],[3,8],[8,10],[19,9],[13,17],[7,3],[20,3],[18,11],[14,6],[3,17],[7,15],[4,10],[18,9],[17,8],[17,7],[6,10],[4,11],[2,11],[5,18],[10,5],[10,4],[10,10],[6,17],[2,7],[11,18],[16,12],[14,17],[5,12],[4,2],[10,7],[14,10],[12,18],[3,3],[11,12],[3,11],[18,15],[8,1],[1,3],[1,18],[9,8],[14,20],[13,9],[13,8],[6,14],[20,20],[8,18],[16,10],[16,6],[15,12],[6,7],[16,13],[12,17],[6,11],[2,9],[18,16],[17,5],[12,12],[2,19],[3,13],[6,19],[11,4],[10,9],[20,14],[15,19],[14,13],[5,2],[5,17],[7,14],[7,19],[18,1],[11,17],[4,5],[8,13],[9,10],[17,19],[12,11],[8,11],[11,5],[11,16],[20,9],[17,2],[18,6],[15,17],[7,17],[10,19],[20,13],[8,12],[9,12],[1,20],[20,6],[10,15],[7,6],[9,6],[1,12],[19,18],[18,8],[15,4],[15,2],[8,7],[6,5],[11,19],[2,8],[8,6],[6,18],[7,9],[3,4],[19,10],[6,4],[9,20],[19,8],[14,16],[7,13],[5,15],[10,2],[20,11],[19,14],[17,11],[15,16],[10,1],[6,16],[4,15],[2,2],[20,17],[20,7],[19,15],[18,4],[17,20],[16,15],[13,14],[4,13],[4,19],[8,20],[4,4],[11,15],[4,20],[11,14],[7,4],[10,16],[3,15],[20,10],[13,12],[2,14],[5,1],[11,11],[3,12],[14,8],[9,3],[7,8],[1,4],[10,20],[6,1],[4,3],[1,10],[17,3],[16,4],[16,2],[6,8],[8,9],[4,16],[17,13],[14,9],[13,19],[12,13],[11,13],[7,7],[3,2],[9,16],[14,3],[5,7],[20,4],[19,19],[18,20],[15,6],[7,5],[18,2],[15,9],[15,3],[14,18],[4,1],[10,12],[2,13],[20,1],[19,7],[5,14],[3,20],[9,4],[5,10],[20,8],[13,20],[12,19],[7,20],[18,18],[17,6],[16,14],[13,16],[20,18],[12,20],[6,6],[20,16],[16,20],[15,11],[9,18],[11,3],[6,9],[14,5],[2,18],[10,18],[19,11],[17,10],[15,5],[13,13],[13,4],[3,18],[18,13],[17,12],[17,9],[16,8],[7,1],[9,17],[12,2],[8,14],[19,1],[16,1],[13,10],[13,7],[1,5],[1,15],[17,17],[1,13],[5,8],[8,5],[19,20],[19,4],[1,1],[9,9],[17,15],[16,9],[13,15],[13,2],[7,11],[4,8],[4,17],[16,3],[12,9],[12,6],[4,12],[3,6],[6,12],[15,14],[1,8],[20,12],[18,14],[6,2],[12,4],[9,13],[18,12],[17,18],[14,2],[13,11],[12,7],[1,7],[11,8],[14,4],[12,16],[9,15],[11,6],[4,7],[12,3],[2,15],[10,8],[10,11],[8,2],[3,19],[8,15],[6,20],[2,20],[8,19],[7,12],[9,11],[11,7],[20,2],[16,18],[1,6],[10,17],[12,14],[9,5],[2,1],[8,17],[1,17],[19,17],[17,14],[16,19],[15,20],[13,1],[10,3],[7,18],[14,1],[5,9],[8,3],[6,15],[2,16],[18,7],[16,11],[11,10],[8,8],[5,6],[3,1],[7,16],[18,10],[16,16],[1,2],[19,6],[15,10],[15,8],[14,12],[10,14],[15,7],[14,7],[11,9],[9,14],[4,9]]

begin
	nodes.each do |coord|
		system("ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@node#{coord[0]}-#{coord[1]} 'nohup /usr/bin/ruby /root/node_looper.rb </dev/null >>/tmp/foo.log &'")
	end
rescue => err
	log.fatal("Caught exception; exiting")
	log.fatal(err)
end


