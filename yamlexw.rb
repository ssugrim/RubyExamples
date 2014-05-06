#!/usr/bin/ruby1.8 -w
# Logger Example

require 'yaml'

data = {
	"Intel Corp. Intel(R) Core(TM) i7 CPU       K 875  @ 2.93GHz 6.14.5" => {
	"shortname" => {
		"ByMfr" => "Intel",
		"ByChipset"=> "K875",
		"ByClock"=> "2.93GHz",
		"ByArch"=> "corei7",
		"ByCore"=> "4"
		},
	"description" => "Intel Corp. Intel(R) Core(TM) i7 CPU K 875 @ 2.93GHz 6.14.5"
	},
	"Intel Corp. Intel(R) Core(TM) i7-3770 CPU @ 3.40GHz 6.10.9" => {
	"shortname" => {
		"ByMfr" => "Intel",
		"ByChipset"=> "NA",
		"ByClock"=> "3.40GHz",
		"ByArch"=> "Corei7-3770",
		"ByCore"=> "4"
		},
	"description" => "Intel Corp. Intel(R) Core(TM) i7-3770 CPU @ 3.40GHz 6.10.9"
	},
	"Intel Corp. Intel(R) Core(TM) i7-2600 CPU @ 3.40GHz 6.10.7" => {
	"shortname" => {
		"ByMfr" => "Intel",
		"ByChipset"=> "NA",
		"ByClock"=> "3.40GHz",
		"ByArch"=> "Corei7-2600",
		"ByCore"=> "4"
		},
	"description" => "Intel Corp. Intel(R) Core(TM) i7-2600 CPU @ 3.40GHz 6.10.7"
	},
	"Intel Corp. Intel(R) Core(TM)2 Quad CPU    Q8400  @ 2.66GHz 6.7.10" => {
	"shortname" => {
		"ByMfr" => "Intel",
		"ByChipset"=> "Q8400",
		"ByClock"=> "2.66GHz",
		"ByArch"=> "Core2 Quad",
		"ByCore"=> "4"
		},
	"description" => "Intel Corp. Intel(R) Core(TM)2 Quad CPU Q8400 @ 2.66GHz 6.7.10"
	},
	"Intel Corp.Intel(R) Core(TM)2 Quad CPU    Q8400  @ 2.66GHz" => {
	"shortname" => {
		"ByMfr" => "Intel",
		"ByChipset"=> "Q8400",
		"ByClock"=> "2.66GHz",
		"ByArch"=> "Core2 Quad",
		"ByCore"=> "4"
		},
	"description" => "Intel Corp. Intel(R) Core(TM)2 Quad CPU Q8400 @ 2.66GHz"
	},
	"Intel Corp.Intel(R) Core(TM) i5 CPU         680  @ 3.60GHz" => {
	"shortname" => {
		"ByMfr" => "Intel",
		"ByChipset"=> "680",
		"ByClock"=> "3.60GHz",
		"ByArch"=> "Corei5",
		"ByCore"=> "4"
		},
	"description" => "Intel Corp.Intel(R) Core(TM) i5 CPU 680 @ 3.60GHz"
	},
	"Intel Corp. Intel(R) Core(TM) i5 CPU         680  @ 3.60GHz 6.5.5" => {
	"shortname" => {
		"ByMfr" => "Intel",
		"ByChipset"=> "680",
		"ByClock"=> "3.60GHz",
		"ByArch"=> "Corei5",
		"ByCore"=> "4"
		},
	"description" => "Intel Corp.Intel(R) Core(TM) i5 CPU 680 @ 3.60GHz 6.5.5"
	},
	"Intel Corp.Intel(R) Core(TM)2 Duo CPU     T9600  @ 2.80GHz" => {
	"shortname" => {
		"ByMfr" => "Intel",
		"ByChipset"=> "T9600",
		"ByClock"=> "2.80GHz",
		"ByArch"=> "Core2 Duo",
		"ByCore"=> "2"
		},
	"description" => "Intel Corp.Intel(R) Core(TM)2 Duo CPU T9600 @ 2.80GHz"
	},
	"Intel Corp. Intel(R) Core(TM)2 Duo CPU     T9600  @ 2.80GHz 6.7.6" => {
	"shortname" => {
		"ByMfr" => "Intel",
		"ByChipset"=> "T9600",
		"ByClock"=> "2.80GHz",
		"ByArch"=> "Core2 Duo",
		"ByCore"=> "2"
		},
	"description" => "Intel Corp.Intel(R) Core(TM)2 Duo CPU T9600 @ 2.80GHz 6.7.6"
	},
	"Intel Corp. Intel(R) Core(TM)2 Duo CPU     T9600  @ 2.80GHz 6.7.10" => {
	"shortname" => {
		"ByMfr" => "Intel",
		"ByChipset"=> "T9600",
		"ByClock"=> "2.80GHz",
		"ByArch"=> "Core2 Duo",
		"ByCore"=> "2"
		},
	"description" => "Intel Corp.Intel(R) Core(TM)2 Duo CPU T9600 @ 2.80GHz 6.7.10"
	},
	"Intel Corp. Intel(R) Core(TM)2 Duo CPU     P8600  @ 2.40GHz 6.7.6" => {
	"shortname" => {
		"ByMfr" => "Intel",
		"ByChipset"=> "P8600",
		"ByClock"=> "2.40GHz",
		"ByArch"=> "Core2 Duo",
		"ByCore"=> "2"
		},
	"description" => "Intel Corp. Intel(R) Core(TM)2 Duo CPU P8600 @ 2.40GHz 6.7.6"
	},
	"Intel Corp. Intel(R) Core(TM)2 Quad CPU    Q6700  @ 2.66GHz 6.15.11" => {
	"shortname" => {
		"ByMfr" => "Intel",
		"ByChipset"=> "Q6700",
		"ByClock"=> "2.66GHz",
		"ByArch"=> "Core2 Quad",
		"ByCore"=> "4"
		},
	"description" => "Intel Corp. Intel(R) Core(TM)2 Quad CPU Q6700 @ 2.66GHz 6.15.11"
	},
	"Intel Corp.Intel(R) Atom(TM) CPU N270   @ 1.60GHz" => {
	"shortname" => {
		"ByMfr" => "Intel",
		"ByChipset"=> "N270",
		"ByClock"=> "1.60GHz",
		"ByArch"=> "Atom",
		"ByCore"=> "1"
		},
	"description" => "Intel Corp.Intel(R) Atom(TM) CPU N270 @ 1.60GHz"
	},
	"Advanced Micro Devices [AMD] AMD Phenom(tm) 9650 Quad-Core Processor 15.2.3" => {
	"shortname" => {
		"ByMfr" => "AMD",
		"ByChipset"=> "9650",
		"ByClock"=> "2.3GHz",
		"ByArch"=> "Phenom",
		"ByCore"=> "4"
		},
	"description" => "Advanced Micro Devices [AMD] AMD Phenom(tm) 9650 Quad-Core Processor 15.2.3"
	},
	"Advanced Micro Devices [AMD]AMD Phenom(tm) 9650 Quad-Core Proces" => {
	"shortname" => {
		"ByMfr" => "AMD",
		"ByChipset"=> "9650",
		"ByClock"=> "2.3GHz",
		"ByArch"=> "Phenom",
		"ByCore"=> "4"
		},
	"description" => "Advanced Micro Devices [AMD] AMD Phenom(tm) 9650 Quad-Core Processor"
	},
	"Samsung VIA Nehemiah VIA C3" => {
	"shortname" => {
		"ByMfr" => "VIA",
		"ByChipset"=> "NA",
		"ByClock"=> "997MHz",
		"ByArch"=> "C3",
		"ByCore"=> "1"
		},
	"description" => "Samsung VIA Nehemiah VIA C3"
	},
	"CentaurHaulsVIA Nehemiah" => {
	"shortname" => {
		"ByMfr" => "VIA",
		"ByChipset"=> "NA",
		"ByClock"=> "997MHz",
		"ByArch"=> "C3",
		"ByCore"=> "1"
		},
	"description" => "CentaurHaulsVIA Nehemiah"
	},
	"CentaurHauls VIA Nehemiah VIA C3" => {
	"shortname" => {
		"ByMfr" => "VIA",
		"ByChipset"=> "NA",
		"ByClock"=> "997MHz",
		"ByArch"=> "C3",
		"ByCore"=> "1"
		},
	"description" => "CentaurHauls VIA Nehemiah VIA C3"
	}
}

File.open("./foo.yml", 'w'){|f| f.write(data.to_yaml)}
