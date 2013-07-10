class LineItem < ActiveRecord::Base
  attr_accessible :product, :cart, :product_id, :cart_id
  belongs_to :product
  belongs_to :cart
end
