class AddTempPasswordColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :temp_password, :string
  end
end
