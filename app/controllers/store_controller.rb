class StoreController < ApplicationController
  def index
    @products = Product.order(:title)
    @count = accessed_time;
    @cart = current_cart;
  end

  private
  def accessed_time
    if session[:counter].nil? then
      return session[:counter] = 1;
    else
      return session[:counter] += 1;
    end
  end

end
