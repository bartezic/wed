class CreatePartnerAds < ActiveRecord::Migration
  def up
    create_table :partner_ads do |t|
      t.references :partner, index: true
      t.attachment :asset
      t.string :asset_remote_url
      t.string :title
      t.text :descroption
      t.boolean :active
      t.date :active_to
      t.string :slug

      t.timestamps
    end

    add_index :partner_ads, :slug, unique: true
    PartnerAd.create_translation_table! title: :string, description: :text
  end

  def down
    remove_index :partner_ads, :slug
    drop_table :partner_ads
    PartnerAd.drop_translation_table!
  end
end
