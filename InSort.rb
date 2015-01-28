data = [15,9,8,1,4,11,7,12,13,6,5,3,16,2,10,14].sort.reverse

def insert(arr, pos, val)
	i = pos - 1
	while( (i >= 0) && (arr[i] > val))
		puts "pos:#{pos} i:#{i} arr[i]:#{arr[i]} val:#{val}"
		arr[i + 1] = arr[i]
		i -= 1
	end	
	arr[i+1] = val
end

for j in 1 .. (data.length - 1)
	insert(data, j, data[j])
end

puts data.join(",")
