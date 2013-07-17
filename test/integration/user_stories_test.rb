require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products

  test "buying a product" do
    # stup the initial condition
    LineItem.delete_all
    Order.delete_all
    ruby_book = products(:ruby);
  
    # access to the index page.
    get "/"
    assert_response :success
    assert_template "index"
  
    # user choices the product and add it to cart.
    xml_http_request :post, '/line_items', product_id: ruby_book.id
    assert_response :success
  
    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size
    assert_equal ruby_book, cart.line_items[0].product
  
    # user checkout the order
    get "/orders/new"
    assert_response :success
    assert_template "new"
  
    # send the request of the checkout.
    post_via_redirect "/orders", order: {name: "Dave Thomas", address: "123 the street", email: "dave@example.com", pay_type: "CASH" }
    assert_response :success
    assert_template "index"
    cart = Cart.find(session[:cart_id]);
    assert_equal 0, cart.line_items.size;

    # veirfy that the line items are generated in database.
    orders = Order.all
    assert_equal 1, orders.size
    order = orders[0]

    assert_equal "Dave Thomas", order.name
    assert_equal "123 the street", order.address
    assert_equal "dave@example.com", order.email
    assert_equal "CASH", order.pay_type

    assert_equal 1, order.line_items.size
    line_item = order.line_items[0]
    assert_equal ruby_book, line_item.product

  end
end
