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
    datastore.inject([]) do |objects, row|
      attributes = row.to_h
      return new(attributes) if elements == 1
      objects << new(attributes)
    end.take(elements)
  end

  def self.last(elements = 1)
    datastore.reverse_each.inject([]) do |objects, row|
      attributes = row.to_h
      return new(attributes) if elements == 1
      objects << new(attributes)
    end.take(elements)
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

  def self.add_object_to_datastore(object, attributes)
    headers = CSV.read(data_path, headers: true, return_headers: true, header_converters: :symbol).headers
    CSV.open(data_path, "a", headers: true, header_converters: :symbol) do |csv|
      csv << new_instance_attributes(object, headers)
    end
  end

  def self.datastore
    CSV.read(data_path, headers: true, return_headers: false, header_converters: :symbol)
  end
end
