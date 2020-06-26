class Course < ActiveRecord::Base
  belongs_to :user
  has_many :classmate_courses
  has_many :classmates, :through => :classmate_courses

  validates :title, :presence=>true
  validates :title, uniqueness: { scope: :user }

  
end
