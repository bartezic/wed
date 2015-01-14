class AddNameMColumnToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :name_m, :string
  end
end
