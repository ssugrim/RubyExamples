#!/usr/bin/ruby1.8 -w
# Logger Example

require 'yaml'

data = YAML.load_file('foo.yml')
data.each{|k,v|
	puts k
	v.each{|x,y|
		puts "-#{x}"
		puts y.map{|z| "--" + z}.join("\n")
	}
}
