class CreateVideos < ActiveRecord::Migration
  def up
    create_table :videos do |t|
      t.string :link
      t.integer :rating, default: 0
      t.references :partner, index: true

      t.timestamps
    end
  end

  def down
    drop_table :videos
  end
end
