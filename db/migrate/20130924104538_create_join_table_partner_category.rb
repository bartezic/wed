class CreateJoinTablePartnerCategory < ActiveRecord::Migration
  def change
    create_join_table :partners, :categories do |t|
      t.index [:partner_id, :category_id]
      t.index [:category_id, :partner_id]
    end
  end
end
