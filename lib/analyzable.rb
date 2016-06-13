module Analyzable
  def self.average_price(items)
    total_price = items.inject(0) do |total, item|
      total += item.price.to_f
    end

    (total_price / items.count).round(2)
  end
end
