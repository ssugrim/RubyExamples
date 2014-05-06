#!/usr/bin/ruby1.8 -w
# Logger Example

require 'yaml'

data = {
	"1234:5678" => {
		"type" => "Atype",
		"names" => {
			"specfic with 2 words" => {
				"url" => "foo.bar.com",
				"description" => "Specfic description"
			},
			"category" => {
				"description" => "Category description"
			}
		}
	},
	"2345:6781" => {
		"type" => "Atype",
		"names" => {
			"specfic" => {
				"url" => "foo.bar.com",
				"description" => "Specfic description"
			},
			"category" => {
				"description" => "Category description"
			}
		}
	}
}

File.open("./foo.yml", 'w'){|f| f.write(data.to_yaml)}
