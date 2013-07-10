class Product < ActiveRecord::Base
  attr_accessible :description, :image_url, :price, :title
  validates :title, :description, :image_url, presence: true;
  validates :title, uniqueness: true;
  validates :price, numericality: {greater_than_or_equal_to: 0.01};
  validates :image_url, allow_blank: true, 
    format: {
      with: %r{\.(gif|jpg|png)$}i,
      message: 'must be either gif, jpeg or png image file.'
    }
  validates :title, length: {minimum: 10} # too_short: 'No! It is TOO SHORT!!!!'
end
