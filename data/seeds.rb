require 'faker'
require_relative '../lib/product'

# This file contains code that populates the database with
# fake data for testing purposes

def db_seed
  # Use faker gem to generate arrays with fake brands, product names, and prices.
  names = []
  10.times do names << Faker::Commerce.product_name end

  brands = []
  10.times do brands << Faker::Company.name end

  prices = []
  10.times do prices << Faker::Commerce.price end

  # Create 10 new Product objects, and save them to the database
  products = (names.zip brands, prices).map do |name, brand, price|
    Product.create name: name, brand: brand, price: price
  end
end
