module Analyzable
  def self.average_price(items)
    total_price = items.inject(0) do |total, item|
      total += item.price.to_f
    end

    (total_price / items.count).round(2)
  end

  def self.print_report(items)
    "Paul"
  end

  def self.count_by_brand(items)
    items.inject(Hash.new(0)) do |brand_count, item|
      brand_count[item.brand] += 1
      brand_count
    end
  end
end
