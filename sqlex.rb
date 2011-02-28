#!/usr/bin/ruby1.8 -w
# writer.rb version 0.96 - verifies data against mysql database and updates if necissary. 
# Major restructring. There should be fewer leaks and misses



require 'mysql'

class Db
	# interacts with databse and returns query results. 
	# only has class methods
	# TODO trap errors with a rescue
	
	# this class should not be instantiateable
	private_class_method :new
	@@ms = nil

	def Db.connect(arr=$params)
		#TODO attempt to reconnect if we trap errors, and rebsumit the query
		@@ms = Mysql.real_connect(arr[0],arr[1],arr[2],arr[3]) unless @@ms
		return @@ms
	end

	def Db.disconnect(ms=@@ms)
		ms.close
	end

	def Db.squery(qs)
		#queries from a string (for special cases) returns an array of arry results
		ms = Db.connect()

		#do the query
		res = ms.query(qs) 
		#panic if we get nothing back
		return nil if res == nil

		#return an arrary of rows
		res_arr = Array.new()
		while row = res.fetch_row do
		       res_arr.push(row)
		end
		
		#TODO should really ensure this
		res.free()

		#don't return empty arrays
		if res_arr.length == 0: return nil else return res_arr end
	end

	def Db.mquery(col, tbl, where=nil)
		#Multi col query, returns an array of values from a single column matched against some hash of parameters
		#col can be a string or array of columns
		#tbl is a string for the table I'm intrested in
		#where is an optional clause that will be matched against
	 	
		ms = Db.connect()
		
		#form a qs from the parameters. 
		#if it's an array form a string of parameters other wise assume its a string
		if col.kind_of?(Array):
			qs = "SELECT "
			col.each {|val| qs << %&#{val},&}
			qs.slice!(qs.length - 1,1)
			qs << " FROM #{tbl}"
		else
			qs = "SELECT #{col} FROM #{tbl}"
		end
		
		#tack on a where clause if we specify a param hash
		if where:
			qs << " WHERE "
			where.each_pair {|key,val| qs << %&#{key} = "#{val}" AND &}
			#lop off the last AND\s, I could do this with a regexp matching single from the back against AND\s
			qs.slice!(qs.length - 4,4)
		end


		#do the query
		res = ms.query(qs) 

		#panic if we get nothing back
		return nil if res == nil
		
		#return an arrary 
		res_arr = Array.new()
		if col.kind_of?(Array):
		#if I got an array, I should expect an array of arrys back
			while row = res.fetch_row do
			res_arr.push(row)
			end
		else 
		#other wise I'll get an array of results, which I will flatten into one array
			while row = res.fetch_row do
			res_arr.push(row)
			end
			res_arr.flatten!
		end

		#TODO should really ensure this
		res.free()

		#don't return empty arrays
		if res_arr.length == 0: return nil else return res_arr end
	end

	def Db.hinsert(table, hsh)
		#Inserts a line into table with params from hsh
		#table is a string that names the mysql table
		#hsh is a hash of attributes for the inserted record, the keys become colunm names and the values become the attributes
	
		ms = Db.connect()
		
		#what table to insert into
		qs = %&INSERT INTO #{table}(&

		#coma seprated column names from the hash keys
		hsh.each_key {|key| qs << "#{key}, "}
		
		#get rid of the traling coma	
		qs.slice!(qs.length-2,2) 
		
		#insert hash values 
		qs << ") VALUES("
		hsh.each_key {|key| qs << %&"#{hsh[key]}", &}

		#get rid of the traling coma	
		qs.slice!(qs.length-2,2) 
		qs << ")"

		ms.query(qs)
		rows = ms.affected_rows

		return rows
	end

	def Db.hupdate(table,set,where )
		#updates fields in table, set is is a hash of updated values, and where is a list of criteria
		ms = Db.connect()

		#primeing
		rows = 0
		
		#form the que string
		qs = %&UPDATE #{table} SET &
		set.each_pair {|key,val| qs << %&#{key}="#{val}", &}

		#get rid of the traling coma	
		qs.slice!(qs.length-2,2) 
	
		qs << " WHERE "

		where.each_pair {|key,val| qs << %&#{key}="#{val}", &}

		#get rid of the traling coma	
		qs.slice!(qs.length-2,2) 

		ms.query(qs)

		#count
		rows += ms.affected_rows
		return rows
	end


end

if __FILE__ == $0
	Db.connect(["internal1.orbit-lab.org","orbit","orbit","inventory2"])
	a = Db.mquery(["id","inventory_id","mfr_sn"],"motherboards")
	b = Db.mquery(["id","inventory_id","mfr_sn"],"inventory.motherboards")
	Db.disconnect

	c = a.map{|v| b.flatten.include?(v[2])}
	a.each_index {|i| puts a[i] unless c[i]}

end
