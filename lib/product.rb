require_relative 'udacidata'

class Product < Udacidata
  attr_accessor :price, :brand, :name
  attr_reader :id

  def initialize(opts={})

    # Get last ID from the database if ID exists
    get_last_id
    # Set the ID if it was passed in, otherwise use last existing ID
    @id = opts[:id] ? opts[:id].to_i : @@count_class_instances
    # Increment ID by 1
    auto_increment if !opts[:id]
    # Set the brand, name, and price normally
    @brand = opts[:brand]
    @name = opts[:name]
    @price = opts[:price]
  end

  def update params
    @price = params[:price] if params[:price]
    @brand = params[:brand] if params[:brand]
    @name = params[:name] if params[:name]
    # get all data
    data = CSV.read(@@file)

    # update the record
    data[@id] = [@id, @price, @brand, @name].map{|val| val.to_s}

    # empty the file
    self.class.superclass.empty_file

    # write the data to the CSV
    CSV.open(@@file, "a") do |csv|
      data.each do |row|
        csv << row
      end
    end
    self
  end

  private

    # Reads the last line of the data file, and gets the id if one exists
    # If it exists, increment and use this value
    # Otherwise, use 0 as starting ID number
    def get_last_id
      last_id = File.exist?(@@file) ? CSV.read(@@file).last[0].to_i + 1 : nil
      @@count_class_instances = last_id || 0
    end

    def auto_increment
      @@count_class_instances += 1
    end

end
