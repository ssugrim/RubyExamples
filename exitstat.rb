#!/usr/bin/ruby1.8 -w
# Logger Example

puts system("ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no #{ARGV[0]} #{ARGV[1]}")

