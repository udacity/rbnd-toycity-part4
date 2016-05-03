require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata

  @@file = File.dirname(__FILE__) + "/../data/data.csv"

  def self.create attributes=nil
    new_data = self.new attributes # create the object
    # If the object's data is already in the database
    CSV.foreach(@@file, headers: true) do |row|
      if row["id"] == new_data.id
        return new_data # return the object
      end
    end
    # If the object's data is not in the database
    CSV.open(@@file, "a") do |csv| # save the data in the database
      csv << [new_data.id, new_data.brand, new_data.name, new_data.price]
    end
    return new_data # return the object
  end

  def self.all
    products = []
    CSV.foreach(@@file, headers: true) do |row|
      products << new(id: row["id"], brand: row["brand"], name: row["product"], price: row["price"])
    end
    products
  end

  def self.first n=1
    n == 1 ? self.all.first : self.all.first(n)
  end

  def self.last n=1
    n == 1 ? self.all.last : self.all.last(n)
  end
end
