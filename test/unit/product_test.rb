require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "price must be positive" do
    product = Product.new(
      title: "My Book Title",
      description: %{this is the description.},
      image_url: 'yyy.jpg')

    product.price = -1
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01",
      product.errors[:price].join('; ');

    product.price = 0
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01",
      product.errors[:price].join('; ');

    product.price = 1
    assert product.valid?
  end

  test "image url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c./x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }

    ok.each do |name|
      assert new_product_with_image_url(name).valid?, "#{name} shouldn't be invalid.}"
    end

    bad.each do |name|
      assert new_product_with_image_url(name).invalid?, "#{name} shouldn't be valid."
    end
  end

  test "product is not valid without a unique title" do
    product = Product.new(
      title: products(:ruby).title,
      description: "yyy",
      price: 1,
      image_url: "image.jpg"
    )
    assert !product.save
    assert_equal I18n.translate('activerecord.errors.messages.taken'), product.errors[:title].join('; ');
  end

  test "product title must have more than 3 characters" do
    ok = %w{123 Tak}
    ng = %w{12 ym}

    ok.each do |name|
      assert new_product_with_title(name).valid?, "#{name} is expected to be valid, but isn't actually."
    end

    ng.each do |name|
      assert new_product_with_title(name).invalid?, "#{name} is expected to be invalid, but isn't actually."
    end
  end

  private 
  def new_product_with_image_url(image_url) 
    Product.new(
      title: "My Test Product",
      description: "yyy",
      price: 1,
      image_url: image_url
    )
  end
  
  def new_product_with_title(title)
    Product.new(
      title: title,
      description: 'yyy',
      price: 10,
      image_url: 'image.jpg'
    )
  end

end
