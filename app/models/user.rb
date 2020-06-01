class User < ActiveRecord::Base

  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :email, format: { with: /\A\w+@\w+.[a-z]+\z/i, message: "address invalid" }

  validates :password, presence: true
  validates :password, length: { in: 6..18 }

  has_many :courses

  has_secure_password
  
end