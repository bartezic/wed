class CreateCooperations < ActiveRecord::Migration
  def change
    create_table :cooperations do |t|
      t.references :partner, index: true
      t.integer :co_id, index: true
      t.boolean :confirmed, default: nil
      t.datetime :confirmed_at

      t.timestamps
    end
  end
end
