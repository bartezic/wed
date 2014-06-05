class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end
    add_index :locations, :slug, unique: true
  end
end
