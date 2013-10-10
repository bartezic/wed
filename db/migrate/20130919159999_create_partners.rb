class CreatePartners < ActiveRecord::Migration
  def up
    create_table :partners do |t|
      t.string      :name
      t.text        :description
      t.text        :info
      t.integer     :price
      t.references  :location,  index: true
      t.string      :site
      t.string      :phone
      t.boolean     :active,    default: false
      t.boolean     :premium,   default: false
      t.date        :premium_to
      t.integer     :rating,    default: 0
      t.string      :slug

      t.timestamps
    end
    
    add_index :partners, :slug, unique: true
    
    Partner.create_translation_table!({
      name: :string,
      description: :text,
      info: :text
    })
  end
  def down
    remove_index :partners, :slug
    drop_table :partners
    Partner.drop_translation_table!
  end
end
