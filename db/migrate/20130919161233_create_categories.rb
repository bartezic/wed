class CreateCategories < ActiveRecord::Migration
  def up
    create_table :categories do |t|
      t.string :name
      t.string :name_sing
      t.string :slug

      t.timestamps
    end
    add_index :categories, :slug, unique: true
    Category.create_translation_table! name: :string, name_sing: :string
  end
  def down
    remove_index :categories, :slug
    drop_table :categories
    Category.drop_translation_table!
  end
end