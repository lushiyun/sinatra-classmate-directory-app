class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.belongs_to :user
      t.string :title
      t.string :professor
      t.string :teaching_assistant
      t.timestamps null: false
    end
  end
end
