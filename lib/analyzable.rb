module Analyzable
  # Your code goes here!

@@data_path = File.dirname(__FILE__) + "/../data/data.csv"


  def average_price(new_array =[])
  		total_price = 0.00
  		avg_price = 
  		new_array.each do |num|
  			total_price = total_price + num.price.to_f
  			
  		end
  		avg_price = total_price/new_array.length.to_f
  		return avg_price.round(2)
	end 
	 	
  
  def print_report(array =[] )
  	report_string = []
#   	report_string << "average_price :" 
  	report_string << " Average Price: #{average_price(array)}" 
  	brand_hash = count_by_brand(array)
  	report_string << "Inventory by Brand:"
  	brand_hash.each do |k,v|
  		report_string << "- #{k}: #{v} "
  	end
  
  	name_hash = count_by_name(array)
  	report_string << "Inventory by Name:"
  	name_hash.each do |k,v|
  		report_string << "- #{k}: #{v} "
  	end
	report_string.each do |str|
	puts str
	end
	
	return report_string.join(",")
	
  end

def count_by_brand(new_array= [])
	brand_hash = Hash.new(0)
   new_array.each do |brand_val|
	
     brand_hash[brand_val.brand] += 1
   end
   return brand_hash 
end

def count_by_name(new_array= [])
	name_hash = Hash.new(0)
   new_array.each do |name_val|
	
     name_hash[name_val.name] += 1
   end
   return name_hash 
end



end

