require_relative 'find_by'
require_relative 'errors'
require 'csv'
require "pry"

class Udacidata
  def self.create(opts={})
    new_instance = new(opts)
    attributes = attributes(opts)
    add_object_to_datastore(new_instance, attributes)

    new_instance
  end

  private

  def self.data_path
    File.dirname(__FILE__) + "/../data/data.csv"
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
    CSV.open(data_path, "a") do |csv|
      csv << new_instance_attributes(object, attributes)
    end
  end
end
