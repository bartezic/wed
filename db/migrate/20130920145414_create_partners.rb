class CreatePartners < ActiveRecord::Migration
  def up
    create_table :partners do |t|
      t.string :name
      t.text :description
      t.text :info
      t.integer :price
      t.integer :location_id
      t.string :site
      t.string :email
      t.string :phone
      t.boolean :active
      t.boolean :premium
      t.date :premium_to
      t.attachment :avatar
      t.integer :rating
      t.string :encrypted_password
      t.string :slug

      t.timestamps
    end
    add_index :partners, :slug, unique: true
    Partner.create_translation_table!({
      name: :string,
      description: :text,
      info: :text,
      encrypted_password: :string
    })
  end
  def down
    remove_index :partners, :slug
    drop_table :partners
    Partner.drop_translation_table!
  end
end
