require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
	@@data_path = File.dirname(__FILE__) + "/../data/data.csv" #giving the file path 
   
  	def self.create(options ={}) #create method creates the product
  		brand = options[:brand]
		name = options[:name]
		price = options[:price]
		product1  = Product.new(brand: brand, name: name, price: price)
		 id = product1.id
		 CSV.open(@@data_path, "ab") do |csv| #opening the CSV file
			csv << [id, brand, name, price]
		end
		return  product1
  	end

  	def self.all #all method returns an array with the all product objects
        array = []
		data = CSV.read(@@data_path).drop(1)
		data.each do |i|
        	array << Product.new(id: i[0], brand: i[1], name: i[2], price: i[3])
        end
        return  array
    end
    
    
	def self.first(n=0) #first method returns the first number of products obejects
		data = CSV.read(@@data_path).drop(1) #reading the data from CSV file 
  		if n == 0
    		return	Product.new(id: data.first[0], brand:data.first[1], name:data.first[2], price:data.first[3])
	    else
     		new_array = []
     		pro_obj =[] #stores the first product objects
     		var = 0
     		while  var < n
     			new_array << data[var]
     			var = var +1
     		end
     		new_array.each do |value|
    			pro_obj << Product.new(id: value[0], brand: value[1], name: value[2], price: value[3])
    		end
 	 		return pro_obj
    	end    
   end     
    
	def self.last(n=0) #last method returns the last number of products objects
		data = CSV.read(@@data_path).drop(1)
  		if n == 0
    		return	Product.new(id: data.last[0], brand:data.last[1], name:data.last[2], price:data.last[3])
		else
     		last_data =  #stores the array of last objects
     	    pro_obj =[]
     		last_data =  data.last(n)
			last_data.each do |value|
    			pro_obj << Product.new(id: value[0], brand: value[1], name: value[2], price: value[3])
	 	 	end
 	 	 	return pro_obj
	    end 
    end
   
	def self.find(n) #finds the number of products
   	 	data = CSV.read(@@data_path).drop(1)
   	  	num =  #stores the index value
   	  	pro_obj = 
	  	index = 0
   		data.each do |i|
   			if i[0] == n.to_s 
   				num = index
			# else
				# 	raise ProductNotFoundError, "#{n} Id does not exist"
			end
			index = index+1 
	 	end
		pro_obj = Product.new(id: data[num][0], brand: data[num][1], name: data[num][2], price: data[num][3])
		return pro_obj
   end
   
   
   def self.destroy(n) # destroys the product with id as n  
      	data2 = CSV.read(@@data_path).drop(1)
      	deleted_product = [] #storing the deleted product in the deleetd array 
		data2.each do |i|
   			if i[0] == n.to_s
   				deleted_product = data2.delete(data2[n])
   				# else
#    				raise ProductNotFoundError, "#{n} Id does not exist"
   			end
   		end    		
   		CSV.open(@@data_path, "wb") do |csv2| #again opening the CSV file and sends the other than deleted product
   	 		csv2 << ["id", "brand", "product", "price"]
			data2.each do |i|
				csv2 << i
			end
		end 
		Product.new(id: deleted_product[0] ,brand: deleted_product[1], name: deleted_product[2], price: deleted_product[3])
   end
# 
 	def self.find_by_brand(brand) #finds the product by brand and returns that product object
		data = CSV.read(@@data_path).drop(1) 
		num = #stores the index value
		index =0
		data.each do |i|
   			if i[1] == brand
				num = index
				break #if it finds the first brand it exits from the loop
   			end
   			index = index + 1
   		end
		return Product.new(id: data[num][0], brand: data[num][1], name: data[num][2], price: data[num][3])
 	end
 	
 	 def self.find_by_name(name) #finds the product by name and returns that product object
		data = CSV.read(@@data_path).drop(1) 
		num =  #stores the index value
		index =0
		data.each do |i|
   			if i[2] == name
				num = index
				break #if it finds the first name it exits from the loop
   			end
   			index = index + 1
   		end
		return Product.new(id: data[num][0], brand: data[num][1], name: data[num][2], price: data[num][3])
 	end
 	
 	
 	def self.where(options={}) #it returns the correct brand or name depends on the product passed 
		data = CSV.read(@@data_path).drop(1) 
		brand = options[:brand]
		name = options[:name]
		brand_array = []  #stores the brand data
		products_array = []
		name_array = [] #stores the name data
		index =0
		data.each do |i|
   			if i[1] == brand
				brand_array << index
   			end
   			index = index + 1
   		end
   		index1 = 0
 		data.each do |i|
   			if i[2] == name
				name_array << index1
   			end
   			index1 = index1 + 1
   		end
   		if name_array.length > 0
   			name_array.each do |index|
   				products_array << Product.new(id: data[index][0], brand: data[index][1], name: data[index][2], price: data[index][3])
   			end
   		else 
   			brand_array.each do |index|
   				products_array << Product.new(id: data[index][0], brand: data[index][1], name: data[index][2], price: data[index][3])
   			end
   		end
   		return products_array
 	end
 	
 	
 	def update(options={})  #updates the product by matching ID with the passed values
      	data = CSV.read(@@data_path).drop(1)
      	brand = options[:brand]
      	price = options[:price].to_s
      	updated_product = [] #stores the obj of updated product
      	data.each do |i|
   			if i[0]== self.id.to_s
   				i[1] = brand
   				i[3] = price
   				updated_product =  Product.new(id: self.id.to_s, brand: brand, name: self.name , price: price.to_f)
   			end
   		end
   		CSV.open(@@data_path, "wb") do |csv| #again opens the CSV file and send the updated data 
   	 		csv << ["id", "brand", "product", "price"]
			data.each do |i|
				csv << i
			end
		 end
		return updated_product
	end 

end
