require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
	@@data_path = File.dirname(__FILE__) + "/../data/data.csv"

   
  def self.create(options ={})
  		brand = options[:brand]
		name = options[:name]
		price = options[:price]
		# p "price"
# 		p brand
		CSV.open(@@data_path, "ab") do |csv|
			csv << [brand, name, price]
		# 	p "csv"
# 			p csv
		end
# 		p "Product.new"
		
		 x = Product.new({brand: brand, name: name, price: price})
		 return x
  end

  def self.all
     i =0
        array = []
        CSV.foreach(@@data_path) do |csv|
				if i !=0
          		 array << self.new(id: csv[0], brand: csv[1], name: csv[2], price: csv[3])
           	end
		 	i =i+1
          end 
         array
    end
    
    
  def self.first(n=0)
  
  	if n == 0
  
  	
	data = CSV.read(@@data_path).drop(1)
    return	Product.new(id: data.first[0], brand:data.first[1], name:data.first[2], price:data.first[3])
    
    else
     new_array = []
     id_array =[]
     data = CSV.read(@@data_path).drop(1)
     var = 0
     while  var < n
     	new_array << data[var]
     	var = var +1
     end
     
     new_array.each do |value|
    	id_array << Product.new(id: value[0], brand: value[1], name: value[2], price: value[3])
    end
 	 return id_array
    end
    
    
   end
 
     
    
  def self.last(n= 0)
  
  	if n ==0
		data = CSV.read(@@data_path).drop(10)
    	return	Product.new(id: data.last[0], brand:data.last[1], name:data.last[2], price:data.last[3])
	else
     	new_array = []
     	data = CSV.read(@@data_path).drop(1)
     	var = 1
     	while  var <= n
     		new_array << data.last(var)
     		var = var +1
     	end

 	 	return new_array
    end 
    
   end
   
   
   def self.find(n)
   	fifth_value = []
   	  data = CSV.read(@@data_path).drop(n+1) 
   	  fifth_value = data[0]
	Product.new(id: fifth_value[0], brand: fifth_value[1], name: fifth_value[2], price: fifth_value[3])
   end
   
   
   def self.destroy(n)
      	data2 = CSV.read(@@data_path).drop(1)
      	deleted_product = []
		data2.each do |i|
   			if i[0] == n.to_s
   				deleted_product = data2.delete(data2[n])
   			end
   		end
   		
   		
   		CSV.open(@@data_path, "wb") do |csv2|
   	 	  csv2 << ["id", "brand", "product", "price"]
			data2.each do |i|
			csv2 << i
			# p "i"
# 			p i
			end
		end 

   
	Product.new(id: deleted_product[0] ,brand: deleted_product[1], name: deleted_product[2], price: deleted_product[3])
   end
#  
 	def self.find_by_brand(brand)
		data = CSV.read(@@data_path).drop(1) 
		num =
		j =0
		data.each do |i|
   			if i[0] == brand
				num = j
				break
   			end
   			j =j+1
   		end
	return Product.new(brand: data[num][0], name: data[num][1], price: data[num][2])
 	end
 	
 	 def self.find_by_name(name)
		data = CSV.read(@@data_path).drop(1) 
		num =
		j =0
		data.each do |i|
   			if i[1] == name
				num = j
				break
   			end
   			j =j+1
   		end
 
		return Product.new(brand: data[num][0], name: data[num][1], price: data[num][2])
 	end
 	
 	
 		def self.where(options={})
		data = CSV.read(@@data_path).drop(1) 
		brand = options[:brand]
		brand_index_array = []
		products_array = []
		j =0
		data.each do |i|
   			if i[0] == brand
   			
				brand_index_array << j
   			end
   			j =j+1
   		end
   		
   		brand_index_array.each do |index|
   			products_array << Product.new(brand: data[index][0], name: data[index][1], price: data[index][2])
   		end
   		return products_array
 	end
 	
 	
 	def update(options = {})
 
      	data = CSV.read(@@data_path).drop(1)
      	brand = options[:brand]
      	price = options[:price].to_s
      	updated_product = []
      	updated_product_array = []
      	data.each do |i|
   			if i[0]== self.id.to_s
   				i[1] = brand
   				i[3] = price
   				updated_product =  Product.new(id: self.id.to_s, brand: brand, name: self.name , price: price.to_f)
   			end
   		end
   		CSV.open(@@data_path, "wb") do |csv|
   	 	  csv << ["id", "brand", "product", "price"]
			data.each do |i|
				csv << i
			end
		 end
	return updated_product
		end 

end
