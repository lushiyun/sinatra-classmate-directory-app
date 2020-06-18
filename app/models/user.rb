class User < ActiveRecord::Base
  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :email, format: { with: /\A\w+@\w+.[a-z]+\z/i, message: "address invalid" }

  validates :password, length: { in: 6..18 }

  has_secure_password

  has_many :courses
  has_many :classmates
  
end