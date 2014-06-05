class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.string      :name
      t.text        :description
      t.text        :info
      t.integer     :price
      t.references  :location,  index: true
      t.string      :site
      t.string      :phone
      t.hstore      :socials
      t.boolean     :callendar, default: true
      t.boolean     :active,    default: false
      t.boolean     :premium,   default: false
      t.date        :premium_to
      t.integer     :rating,    default: 0
      t.string      :slug

      t.timestamps
    end
    
    add_index :partners, :slug, unique: true
  end
end
