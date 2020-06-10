class AddEmailToClassmates < ActiveRecord::Migration[6.0]
  def change
    add_column :classmates, :email, :string
  end
end
