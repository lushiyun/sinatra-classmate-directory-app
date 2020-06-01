class CreateClassmates < ActiveRecord::Migration[6.0]
  def change
    create_table :classmates do |t|
      t.belongs_to :user
      t.string :name
      t.date :birthday
      t.timestamps null: false
    end
  end
end
