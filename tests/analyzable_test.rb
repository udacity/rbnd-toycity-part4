require 'minitest/autorun'
require_relative '../lib/product'
require_relative '../lib/analyzable'
require_relative '../data/seeds'

include Analyzable

class TestAnalyzable < MiniTest::Test

  def setup
    @data_path = File.dirname(__FILE__) + "/../data/data.csv"
    CSV.open(@data_path, "wb") do |csv|
      csv << ["id", "brand", "product", "price"]
    end
    db_seed
  end

  def test_average_price_method_returns_average_price
    p1 = Product.create(brand: "AverageBrand", name: "Nyan Cat", price: 15.32)
    p2 = Product.create(brand: "AverageBrand", name: "Nyan Cat", price: 18.23)
    p3 = Product.create(brand: "AverageBrand", name: "Nyan Cat", price: 11.30)
    avg = Analyzable::average_price(Product.where(brand: "AverageBrand"))
    assert_equal(14.95, avg)
  end

  def test_print_report_returns_report_string
    report = Analyzable::print_report(Product.all)
    assert_kind_of(String, report)
  end
  #
  def test_count_by_brand_method_returns_hash
    Product.create(brand: "FindMyBrand", name: "Skateboard", price: "11.30")
    expected = { "FindMyBrand" => 1 }
    actual = Analyzable::count_by_brand(Product.where(brand: "FindMyBrand"))
    assert_equal(expected, actual)
  end
  #
  def test_count_by_name_method_returns_hash
    Product.create(brand: "Lego", name: "FindMyName", price: "11.30")
    expected = { "FindMyName" => 1 }
    actual = Analyzable::count_by_name(Product.where(name: "FindMyName"))
    assert_equal(expected, actual)
  end

  # The "teardown" method always runs after the tests are done
  # "teardown" will delete the test database when tests are done
  def teardown
    File.delete(@data_path)
  end

end
