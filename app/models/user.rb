class User < ActiveRecord::Base
  after_destroy :ensure_an_admin_remains
  attr_accessible :name, :password_digest, :password, :password_confirmation
  validates :name, presence: true, uniqueness: true
  has_secure_password

  private
  def ensure_an_admin_remains
    if(User.count.zero?) then
      raise "The last user can't be deleted."
    end
  end
end
