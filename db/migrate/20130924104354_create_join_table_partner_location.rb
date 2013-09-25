class CreateJoinTablePartnerLocation < ActiveRecord::Migration
  def change
    create_join_table :partners, :locations do |t|
      t.index [:partner_id, :location_id]
      t.index [:location_id, :partner_id]
    end
  end
end
