require 'faker'

# This file contains code that populates the database with
# fake data for testing purposes

def db_seed

  100.times do
    Product.create( brand: Faker::Company.name, 
                    name: Faker::Commerce.product_name, 
                    price: Faker::Commerece.price )
  end
end
