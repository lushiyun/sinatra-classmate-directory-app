class Classmate < ActiveRecord::Base
  belongs_to :user
  has_many :classmate_courses
  has_many :courses, :through => :classmate_courses
  
  validates :name, :presence=>true
  # validates :name, uniqueness: { scope: :user }
  # there are 3 Drews for Bob
end
