require 'faker'

# This file contains code that populates the database with
# fake data for testing purposes

def db_seed
  10.times do
    brand = Faker::Company.name
    name = Faker::Commerce.product_name
    price = Faker::Commerce.price

    Product.create(brand: brand, name: name, price: price)
  end
end
