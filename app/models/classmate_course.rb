class ClassmateCourse < ActiveRecord::Base
  belongs_to :classmate
  belongs_to :course

  # validates uniqueness with scope
end