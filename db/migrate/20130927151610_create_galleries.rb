class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :name
      t.text :description
      t.integer :rating, default: 0
      t.references :partner, index: true
      t.string :slug

      t.timestamps
    end
    add_index :galleries, :slug, unique: true
  end
end
