class CreateSliderAds < ActiveRecord::Migration
  def change
    create_table :slider_ads do |t|
      t.references :partner, index: true
      t.attachment :asset
      t.string :asset_remote_url
      t.hstore :text
      t.boolean :active
      t.date :active_to

      t.timestamps
    end
  end
end
