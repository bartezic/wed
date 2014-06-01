class CreateInvolvings < ActiveRecord::Migration
  def change
    create_table :involvings do |t|
      t.integer :price
      t.references :partner
      t.references :category
    end
  end
end
