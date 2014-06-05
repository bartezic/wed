class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string      :name
      t.string      :name_sing
      t.string      :slug
      t.attachment  :logo
      t.string      :logo_remote_url

      t.timestamps
    end
    add_index :categories, :slug, unique: true
  end
end