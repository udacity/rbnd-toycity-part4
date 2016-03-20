require 'faker'

# This file contains code that populates the database with
# fake data for testing purposes
#  p "Hello"
def db_seed
  
  data_path = File.dirname(__FILE__) + "/data.csv"
# data_path =  "/ruby_toycity_4/data/data.csv"
# p "Inside data path"
      CSV.open(data_path, "ab") do |csv|
      	10.times do |r|
      	
      	 	brand = Faker::Company.name
  			name = Faker::Commerce.product_name
  			price = Faker::Commerce.price

  			product = Product.new(id: r, brand: brand, name: name, price: price)
  			csv << [r, product.brand, product.name, product.price ]
  			   #    	puts csv
# 
#   			p r
#       		p product.brand
#       	p product.name
#       	p product.price
      	end
      	
	   end	
	   
end
