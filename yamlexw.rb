#!/usr/bin/ruby1.8 -w
# Logger Example

require 'yaml'

data = {
	"Intel Corp. Intel(R) Core(TM) i7 CPU       K 875  @ 2.93GHz 6.14.5" => {
	"shortname" => ["Intel","K875","2.93GHz","corei7","4"],
	"description" => "Intel Corp. Intel(R) Core(TM) i7 CPU K 875 @ 2.93GHz 6.14.5",
	"type" => ["ByMfr","ByChipset","ByClock","ByArch","ByCore"]
	},
	"Intel Corp. Intel(R) Core(TM) i7-3770 CPU @ 3.40GHz 6.10.9" => {
	"shortname" => ["Intel","NA","3.40GHz","Corei7-3770","4"],
	"description" => "Intel Corp. Intel(R) Core(TM) i7-3770 CPU @ 3.40GHz 6.10.9",
	"type" => ["ByMfr","ByChipset","ByClock","ByArch","ByCore"]
	},
	"Intel Corp. Intel(R) Core(TM) i7-2600 CPU @ 3.40GHz 6.10.7" => {
	"shortname" => ["Intel","NA","3.40GHz","Corei7-2600","4"],
	"description" => "Intel Corp. Intel(R) Core(TM) i7-2600 CPU @ 3.40GHz 6.10.7",
	"type" => ["ByMfr","ByChipset","ByClock","ByArch","ByCore"]
	},
	"Intel Corp. Intel(R) Core(TM)2 Quad CPU    Q8400  @ 2.66GHz 6.7.10" => {
	"shortname" => ["Intel","Q8400","2.66GHz","Core2 Quad","4"],
	"description" => "Intel Corp. Intel(R) Core(TM)2 Quad CPU Q8400 @ 2.66GHz 6.7.10",
	"type" => ["ByMfr","ByChipset","ByClock","ByArch","ByCore"]
	},
	"Intel Corp.Intel(R) Core(TM)2 Quad CPU    Q8400  @ 2.66GHz" => {
	"shortname" => ["Intel","Q8400","2.66GHz","Core2 Quad","4"],
	"description" => "Intel Corp. Intel(R) Core(TM)2 Quad CPU Q8400 @ 2.66GHz",
	"type" => ["ByMfr","ByChipset","ByClock","ByArch","ByCore"]
	},
	"Intel Corp.Intel(R) Core(TM) i5 CPU         680  @ 3.60GHz" => {
	"shortname" => ["Intel","680","3.60GHz","Corei5","4"],
	"description" => "Intel Corp.Intel(R) Core(TM) i5 CPU 680 @ 3.60GHz",
	"type" => ["ByMfr","ByChipset","ByClock","ByArch","ByCore"]
	},
	"Intel Corp. Intel(R) Core(TM) i5 CPU         680  @ 3.60GHz 6.5.5" => {
	"shortname" => ["Intel","680","3.60GHz","Corei5","4"],
	"description" => "Intel Corp.Intel(R) Core(TM) i5 CPU 680 @ 3.60GHz 6.5.5",
	"type" => ["ByMfr","ByChipset","ByClock","ByArch","ByCore"]
	},
	"Intel Corp.Intel(R) Core(TM)2 Duo CPU     T9600  @ 2.80GHz" => {
	"shortname" => ["Intel","T9600","2.80GHz","Core2 Duo","2"],
	"description" => "Intel Corp.Intel(R) Core(TM)2 Duo CPU T9600 @ 2.80GHz",
	"type" => ["ByMfr","ByChipset","ByClock","ByArch","ByCore"]
	},
	"Intel Corp. Intel(R) Core(TM)2 Duo CPU     T9600  @ 2.80GHz 6.7.6" => {
	"shortname" => ["Intel","T9600","2.80GHz","Core2 Duo","2"],
	"description" => "Intel Corp.Intel(R) Core(TM)2 Duo CPU T9600 @ 2.80GHz 6.7.6",
	"type" => ["ByMfr","ByChipset","ByClock","ByArch","ByCore"]
	},
	"Intel Corp. Intel(R) Core(TM)2 Duo CPU     T9600  @ 2.80GHz 6.7.10" => {
	"shortname" => ["Intel","T9600","2.80GHz","Core2 Duo","2"],
	"description" => "Intel Corp.Intel(R) Core(TM)2 Duo CPU T9600 @ 2.80GHz 6.7.10",
	"type" => ["ByMfr","ByChipset","ByClock","ByArch","ByCore"]
	},
	"Intel Corp. Intel(R) Core(TM)2 Duo CPU     P8600  @ 2.40GHz 6.7.6" => {
	"shortname" => ["Intel","P8600","2.40GHz","Core2 Duo","2"],
	"description" => "Intel Corp. Intel(R) Core(TM)2 Duo CPU P8600 @ 2.40GHz 6.7.6",
	"type" => ["ByMfr","ByChipset","ByClock","ByArch","ByCore"]
	},
	"Intel Corp. Intel(R) Core(TM)2 Quad CPU    Q6700  @ 2.66GHz 6.15.11" => {
	"shortname" => ["Intel","Q6700","2.66GHz","Core2 Quad","4"],
	"description" => "Intel Corp. Intel(R) Core(TM)2 Quad CPU Q6700 @ 2.66GHz 6.15.11",
	"type" => ["ByMfr","ByChipset","ByClock","ByArch","ByCore"]
	},
	"Intel Corp.Intel(R) Atom(TM) CPU N270   @ 1.60GHz" => {
	"shortname" => ["Intel","N270","1.60GHz","Atom","1"],
	"description" => "Intel Corp.Intel(R) Atom(TM) CPU N270 @ 1.60GHz",
	"type" => ["ByMfr","ByChipset","ByClock","ByArch","ByCore"]
	},
	"Advanced Micro Devices [AMD] AMD Phenom(tm) 9650 Quad-Core Processor 15.2.3" => {
	"shortname" => ["AMD","9650","2.3GHz","Phenom","4"],
	"description" => "Advanced Micro Devices [AMD] AMD Phenom(tm) 9650 Quad-Core Processor 15.2.3",
	"type" => ["ByMfr","ByChipset","ByClock","ByArch","ByCore"]
	},
	"Advanced Micro Devices [AMD]AMD Phenom(tm) 9650 Quad-Core Proces" => {
	"shortname" => ["AMD","9650","2.3GHz","Phenom","4"],
	"description" => "Advanced Micro Devices [AMD] AMD Phenom(tm) 9650 Quad-Core Processor",
	"type" => ["ByMfr","ByChipset","ByClock","ByArch","ByCore"]
	},
	"Intel Corp. Intel(R) Core(TM)2 Quad CPU    Q6700  @ 2.66GHz 6.15.11" => {
	"shortname" => ["Intel","Q6700","2.66GHz","Core2 Quad","4"],
	"description" => "Intel Corp. Intel(R) Core(TM)2 Quad CPU Q6700 @ 2.66GHz 6.15.11",
	"type" => ["ByMfr","ByChipset","ByClock","ByArch","ByCore"]
	}
}

File.open("./foo.yml", 'w'){|f| f.write(data.to_yaml)}
