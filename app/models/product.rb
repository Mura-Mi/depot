class Product < ActiveRecord::Base
  attr_accessible :description, :image_url, :price, :title

  has_many :line_items
  has_many :orders, through: :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  # Validation methods
  validates :title, :description, :image_url, presence: true;
  validates :title, uniqueness: true;
  validates :price, numericality: {greater_than_or_equal_to: 0.01};
  validates :image_url, allow_blank: true, 
    format: {
      with: %r{\.(gif|jpg|png)$}i,
      message: 'must be either gif, jpeg or png image file.'
    }
  validates :title, length: {minimum: 3} 


  private
  def ensure_not_referenced_by_any_line_item 
    if line_items.empty?
      return true;
    else
      errors.add(:base, 'There is some line_item that reference this product.');
      return false;
    end
  end


end
