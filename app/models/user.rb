class User < ActiveRecord::Base

  has_secure_password

  
  def self.authenticate_with_credentials(email, password)
    email = email.split(' ')[0].downcase
    user = User.find_by_email(email)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8 }
  validates :password_confirmation, presence: true
  before_save { self.email = email.downcase }
  
end
