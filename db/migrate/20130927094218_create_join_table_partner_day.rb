class CreateJoinTablePartnerDay < ActiveRecord::Migration
  def change
    create_join_table :partners, :days do |t|
      t.index [:partner_id, :day_id]
      t.index [:day_id, :partner_id]
    end
  end
end
