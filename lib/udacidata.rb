require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  create_finder_methods "name", "brand"

  @@file = File.dirname(__FILE__) + "/../data/data.csv"

  def self.create attributes=nil
    new_data = new attributes # create the object
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
    n == 1 ? all.first : all.first(n)
  end

  def self.last n=1
    n == 1 ? all.last : all.last(n)
  end

  def self.find id
    product = all.select{|data| data.id == id}.first
    raise ProductNotFoundError, "Product Id #{id} not found." if product.nil?
    product
  end

  def self.destroy id
    deleted_data = find id
    raise ProductNotFoundError, "Product Id #{id} not found." if deleted_data.nil?
    data = all.delete_if {|data| data.id == id}
    empty_file
    write_file data
    deleted_data
  end

  def self.write_file data
    CSV.open(@@file, "a") do |csv|
      csv << ["id", "brand", "product", "price"]
      data.each do |item|
        csv << [item.id, item.brand, item.name, item.price]
      end
    end
  end

  def self.empty_file
    File.open(@@file, 'w') {|file| file.truncate(0) }
  end

  def self.where hash
    all.select{|data| data.send(hash.keys.first) == hash.values.first}
  end
end
