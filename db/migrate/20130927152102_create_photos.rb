class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.attachment :asset
      t.string :asset_remote_url
      t.integer :rating, default: 0
      t.references :gallery, index: true

      t.timestamps
    end
  end
end
