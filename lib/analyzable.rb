module Analyzable  #module analyzable
@@data_path = File.dirname(__FILE__) + "/../data/data.csv"

  def average_price(new_array =[]) #this method calculates the average price of all the toys
  		total_price = 0.00
  		avg_price = 
  		new_array.each do |num| #loop calculates the total price of toys
  			total_price = total_price + num.price.to_f
  		end
  		avg_price = total_price/new_array.length.to_f #averaging the total price with total number of products
  		return avg_price.round(2)
	end 
  
	def print_report(array =[]) #returns all the report of all the data
  		report_string = []
  		report_string << " Average Price: #{average_price(array)}" #pushing avg_price to array
  		brand_hash = count_by_brand(array)
  		report_string << "Inventory by Brand:"  #pushing brand data
  		brand_hash.each do |k,v|
  			report_string << "- #{k}: #{v} "
  		end
  		name_hash = count_by_name(array)
  		report_string << "Inventory by Name:" #pushing through name
  		name_hash.each do |k,v|
  			report_string << "- #{k}: #{v} "
  		end
		report_string.each do |str|
			puts str
		end
		return report_string.join(",")
	end

	def count_by_brand(new_array= [])   #counts the data through brand
		brand_hash = Hash.new(0)
   		new_array.each do |brand_val|
     		brand_hash[brand_val.brand] += 1 
   		end
   		return brand_hash  #returns brand hash with toys data
	end

	def count_by_name(new_array= [])  #counts the data by name
		name_hash = Hash.new(0)
   		new_array.each do |name_val|
     		name_hash[name_val.name] += 1
   		end
   		return name_hash  #returns name hash with toys data
	end


end

