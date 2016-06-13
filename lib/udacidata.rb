require_relative 'find_by'
require_relative 'errors'
require 'csv'
require "pry"

class Udacidata
  DATA_FILE = "/../data/data.csv"

  def self.create(opts={})
    new_instance = new(opts)
    opts_with_id = opts.merge(id: new_instance.id)
    attributes = attributes(opts_with_id)
    create_finder_methods(*opts.keys)

    add_object_to_datastore(new_instance, attributes)

    new_instance
  end

  def self.all
    datastore.inject([]) do |objects, row|
      attributes = row.to_h
      objects << new(attributes)
    end
  end

  def self.first(elements = 1)
    if elements == 1
      all.first
    else
      all.take(elements)
    end
  end

  def self.last(elements = 1)
    if elements == 1
      all.last
    else
      all.reverse.take(elements)
    end
  end

  def self.find(index)
    check_product_exists(index)
    all.find { |item| item.id == index }
  end

  def self.destroy(index)
    check_product_exists(index)
    item_to_delete = find(index)

    table_csv_file = self.table_csv_file
    table_csv_file.each_with_index do |item, index|
      if item[:id].to_i == item_to_delete.id
        table_csv_file.delete(index)
      end
    end

    update_data_store(table_csv_file)
    item_to_delete
  end

  def self.where(filter)
    attribute = filter.keys.first
    value = filter[attribute]

    all.select do |item|
      item.send(attribute) == value
    end
  end

  def update(attributes)
    item_to_update = self

    table_csv_file = self.class.table_csv_file
    table_csv_row_to_update = table_csv_file.find do |item|
      item[:id].to_i == item_to_update.id
    end

    attributes.each do |attribute, new_value|
      table_csv_file[table_csv_row_to_update][attribute] = new_value
      self.send("#{attribute}=", new_value)
    end

    self.class.update_data_store(table_csv_file)

    item_to_update
  end

  private

  def self.data_path
    File.dirname(__FILE__) + DATA_FILE
  end

  def self.new_instance_attributes(object, object_attributes)
    object_attributes.map do |attribute|
      object.send(attribute)
    end
  end

  def self.attributes(parameters)
    parameters.keys
  end

  def self.headers
    CSV.read(data_path, headers: true, return_headers: true, header_converters: :symbol).headers
  end

  def self.add_object_to_datastore(object, attributes)
    CSV.open(data_path, "a", headers: true, header_converters: :symbol) do |csv|
      csv << new_instance_attributes(object, self.headers)
    end
  end

  def self.datastore
    CSV.read(data_path, headers: true, return_headers: false, header_converters: :symbol)
  end

  def self.table_csv_file
    CSV.read(data_path, headers: true, return_headers: true, header_converters: :symbol)
  end

  def self.update_data_store(table_csv_file)
    CSV.open(Udacidata.data_path, "w", headers: true, header_converters: :symbol) do |csv|
      table_csv_file.each do |row|
        csv << row
      end
    end
  end

  def self.check_product_exists(index)
    unless all[index - 1]
      raise ProductNotFoundError, "The Product with ID #{index} cannot be found."
    end
  end
end
