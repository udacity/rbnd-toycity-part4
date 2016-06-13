module Analyzable
  def self.average_price(items)
    total_price = items.inject(0) do |total, item|
      total += item.price.to_f
    end

    (total_price / items.count).round(2)
  end

  def self.print_report(items)
    report = "Inventory by Brand:\n"

    count_by_brand(items).each do |brand, count|
      report += "- #{brand}: #{count}\n"
    end

    report += "Inventory by Name:\n"

    count_by_name(items).each do |name, count|
      report += "- #{name}: #{count}\n"
    end

    report
  end

  def self.count_by_brand(items)
    items.each_with_object(Hash.new(0)) do |item, brand_count|
      brand_count[item.brand] += 1
    end
  end

  def self.count_by_name(items)
    items.each_with_object(Hash.new(0)) do |item, name_count|
      name_count[item.name] += 1
    end
  end
end
