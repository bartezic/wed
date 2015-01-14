class AddSeoColumnsToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :meta_description, :string
    add_column :categories, :meta_keywords, :string
  end
end
