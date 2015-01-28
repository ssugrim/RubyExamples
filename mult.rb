#example 2-4, pg 30

@n1 = [1,2,3]
@n2 = [0,4,2]

@res = Array.new([@n1.length,@n2.length].max * 2){|ind| 0}

@pos = @res.length-1

for i in 0..(@n1.length-1)
	@m = (@n1.length-1) - i #sloppy decerement since for can only increment
	@off = (@n1.length-1) - @m #really just i
	for n in 0..(@n2.length-1)
                @off +=  1
		@prod = @n1[@m] * @n2[n]
		puts "pos:#{@pos} off:#{@off} res:#{@res.join(",")} m:#{@m} n:#{n} prod:#{@prod}"
		@res[@pos - @off] += @prod % 10
		@res[@pos - @off - 1] += (@res[@pos - @off] / 10).floor + ( @prod / 10).floor
		@res[@pos - @off] %= 10
	end
end

