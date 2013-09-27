class CreateGalleries < ActiveRecord::Migration
  def up
    create_table :galleries do |t|
      t.string :name
      t.text :description
      t.integer :rating, default: 0
      t.references :partner, index: true
      t.string :slug

      t.timestamps
    end
    add_index :galleries, :slug, unique: true
    Gallery.create_translation_table! name: :string, description: :text
  end

  def down
    remove_index :galleries, :slug
    drop_table :galleries
    Gallery.drop_translation_table!
  end
end
