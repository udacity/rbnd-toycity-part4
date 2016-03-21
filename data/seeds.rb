require 'faker'

# This file contains code that populates the database with
# fake data for testing purposes
def db_seed
  
  data_path = File.dirname(__FILE__) + "/data.csv"
      CSV.open(data_path, "ab") do |csv|
      	10.times do |id|  #looping 10 times to get the data
      	
      	 	brand = Faker::Company.name #getting name brand, price from faker gem
  			name = Faker::Commerce.product_name
  			price = Faker::Commerce.price

  			product = Product.new(id: id, brand: brand, name: name, price: price)
  			csv << [id, product.brand, product.name, product.price ]  #pushing id, name, brand,price to csv 
  
      	end
      	
	   end	
	   
end
