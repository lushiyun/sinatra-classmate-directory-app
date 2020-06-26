class ClassmateCourse < ActiveRecord::Base
  belongs_to :classmate
  belongs_to :course

  validates :classmate_id, uniqueness: { scope: :course_id }
end