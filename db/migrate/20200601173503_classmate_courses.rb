class ClassmateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :classmate_courses do |t|
      t.belongs_to :classmate
      t.belongs_to :course
    end
  end
end
