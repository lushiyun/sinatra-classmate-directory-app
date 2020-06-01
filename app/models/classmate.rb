class Classmate < ActiveRecord::Base
  belongs_to :user
  has_many :classmate_courses
  has_many :courses, through: :classmate_courses
end
