class AddPositionToVideosAndPhotosAndGalleries < ActiveRecord::Migration
  def change
    add_column :videos, :position, :integer
    add_column :photos, :position, :integer
    add_column :galleries, :position, :integer
  end
end
