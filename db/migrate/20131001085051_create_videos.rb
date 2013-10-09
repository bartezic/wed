class CreateVideos < ActiveRecord::Migration
  def up
    create_table :videos do |t|
      t.string :name
      t.text :description
      t.string :link
      t.integer :rating, default: 0
      t.references :partner, index: true

      t.timestamps
    end
    Video.create_translation_table! name: :string, description: :text
  end

  def down
    drop_table :videos
    Video.drop_translation_table!
  end
end
