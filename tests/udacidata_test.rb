require 'minitest/autorun'
require_relative '../lib/product'
require_relative '../data/seeds'

class TestUdacidata < MiniTest::Test

  def setup
    @data_path = File.dirname(__FILE__) + "/../data/data.csv"
    CSV.open(@data_path, "wb") do |csv|
      csv << ["id", "brand", "product", "price"]
    end
    db_seed
  end

  def test_create_method_adds_to_database
    before = CSV.read(@data_path).length
    5.times do
      Product.create(brand: "WalterToys", name: "Sticky Notes", price: 34.00)
    end
    after = CSV.read(@data_path).length
    assert(after == before + 5)
  end

  def test_create_method_returns_product_object
     product = Product.create(brand: "ColtToys", name: "Orchid Plant", price: 2.00)
     assert_instance_of(Product, product)
  end

  def test_all_method_returns_array_data_type
    array_of_products = Product.all
    assert_kind_of(Array, array_of_products)
  end

  def test_all_method_returns_array_of_products
    array_of_products = Product.all
    array_of_products.each do |product|
      assert_instance_of(Product, product)
    end
  end

  def test_all_method_returns_all_products_in_database
    expected = CSV.read(@data_path).drop(1).length
    actual = Product.all.length
    assert_equal(expected, actual)
  end

  def test_first_method_returns_product_object
    product = Product.first
    assert_instance_of(Product, product)
  end

  def test_first_method_returns_correct_product
    product = Product.first
    data = CSV.read(@data_path).drop(1)
    assert_equal(data.first[0].to_i, product.id)
  end

  def test_first_n_returns_array
    array_of_products = Product.first(3)
    assert_kind_of(Array, array_of_products)
  end

  def test_first_n_returns_correct_products
    array_of_products = Product.first(3)
    data = CSV.read(@data_path).drop(1)
    array_of_products.each_with_index do |product, index|
      assert_equal(data[index][0].to_i, product.id)
    end
  end

  def test_first_n_returns_correct_number_of_products
    array_of_products = Product.first(3)
    assert_equal(3, array_of_products.size)
  end

  def test_last_method_returns_product_object
    product = Product.last
    assert_instance_of(Product, product)
  end

  def test_last_method_returns_correct_product
    product = Product.last
    data = CSV.read(@data_path).drop(1)
    assert_equal(data.last[0].to_i, product.id)
  end

  def test_last_n_returns_array_type
    array_of_products = Product.last(3)
    assert_kind_of(Array, array_of_products)
  end

  def test_last_n_returns_correct_number_of_products
    array_of_products = Product.last(3)
    assert_equal(3, array_of_products.size)
  end

  def test_find_method_returns_correct_product
    product = Product.find(5)
    assert_equal(5, product.id)
  end

  def test_find_method_returns_product_object
    product = Product.find(5)
    assert_instance_of(Product, product)
  end

  def test_destroy_method_removes_product_from_database
    before = CSV.read(@data_path).length
    Product.destroy(2)
    after = CSV.read(@data_path).length
    assert_equal(before - 1, after)
  end

  def test_destroy_method_returns_deleted_product
    product = Product.destroy(7)
    assert_equal(7, product.id)
  end

  def test_find_by_brand_method_returns_first_product_with_given_brand
    Product.create(brand: "OritToys", name: "Sticky Notes", price: 34.00)
    product = Product.find_by_brand("OritToys")
    assert_equal("OritToys", product.brand)
  end

  def test_find_by_name_method_returns_first_product_with_given_name
    Product.create(brand: "OritToys", name: "Nyan Cat", price: 3.00)
    product = Product.find_by_name("Nyan Cat")
    assert_equal("Nyan Cat", product.name)
  end

  def test_where_method_returns_array_type
    Product.create(brand: "Lego", name: "Sticky Notes", price: 34.00)
    array_of_products = Product.where(brand: "Lego")
    assert_kind_of(Array, array_of_products)
  end

  def test_where_method_returns_correct_products
    Product.create(brand: "Lego", name: "Sticky Notes", price: 34.00)
    array_of_products = Product.where(brand: "Lego")
    array_of_products.each do |product|
      assert_equal("Lego", product.brand)
    end
  end

  def test_update_info_of_existing_product
    product = Product.find(4).update(price: 100000.00, brand: "Lolerskater")
    actual = [product.price.to_f, product.brand]
    expected = [100000.00, "Lolerskater"]
    assert_equal(expected, actual)
  end

  def test_update_changes_product_info_in_database
    database_before = CSV.read(@data_path)
    product = Product.find(3).update(price: 5000.00, brand: "Hello World")
    database_after = CSV.read(@data_path)
    diff = (database_after - database_before).first
    assert_equal(diff.include?("Hello World"), true)
    assert_equal(database_before.size, database_after.size)
  end

  # The "teardown" method always runs after the tests are done
  # "teardown" will delete the test database when tests are done
  def teardown
    File.delete(@data_path)
  end

end
