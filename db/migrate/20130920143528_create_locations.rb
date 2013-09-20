class CreateLocations < ActiveRecord::Migration
  def up
    create_table :locations do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end
    add_index :locations, :slug, unique: true
    Location.create_translation_table! name: :string
  end
  def down
    remove_index :locations, :slug
    drop_table :locations
    Location.drop_translation_table!
  end
end
