# This file contains instructions for how to create a database.
# If the file does not exist yet, it opens a new writable file
# and adds a header for the columns: id, brand, product, price

# puts "hello"
def db_create
  data_path = File.dirname(__FILE__) + "/data.csv"
#    data_path =  "/ruby_toycity_4/data/data.csv"
# puts "after data_path"

  if !File.exist?(data_path)
#   	puts "inside file doesn't exist"
    CSV.open(data_path, "wb") do |csv|
#       	puts "inside CSV open"

      csv << ["id", "brand", "product", "price"]
    end
  end
end
