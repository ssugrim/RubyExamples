
a = "I wish you a merry christmas today".split(" ")
puts a.join(" ")

(0..(a.length/2)).to_a.each{|i|
back = a.length - i - 1
puts " #{i} #{a[i]} #{a[back]}"
dummy = a[i]
a[i] = a[back]
a[back] = dummy
}
puts a.join(" ")
