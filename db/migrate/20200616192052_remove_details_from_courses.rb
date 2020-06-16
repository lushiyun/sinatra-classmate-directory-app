class RemoveDetailsFromCourses < ActiveRecord::Migration[6.0]
  def change
    remove_column :courses, :professor, :string
    remove_column :courses, :teaching_assistant, :string
  end
end
