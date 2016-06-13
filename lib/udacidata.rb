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
    all[index - 1]
  end

  def self.destroy(index)
    deleted_item = all.delete_at(index - 1)

    table_csv = CSV.read(data_path, headers: true, return_headers: true, header_converters: :symbol)
    table_csv.delete(index)

    CSV.open(data_path, "w", headers: true, header_converters: :symbol) do |csv|
      table_csv.each do |row|
        csv << row
      end
    end

    deleted_item
  end

  def self.where(filter)
    attribute = filter.keys.first
    value = filter[attribute]

    all.select do |item|
      item.send(attribute) == value
    end
  end

  def update(attributes)
    updated_object = self.class.new(attributes)
    table_csv = CSV.read(Udacidata.data_path, headers: true, return_headers: true, header_converters: :symbol)

    attributes.each do |attribute, new_value|
      table_csv[updated_object.id - 1][attribute] = new_value
    end

    CSV.open(Udacidata.data_path, "w", headers: true, header_converters: :symbol) do |csv|
      table_csv.each do |row|
        csv << row
      end
    end

    updated_object
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
end
