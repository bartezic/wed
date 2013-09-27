class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.date :day_of_life

      t.timestamps
    end
  end
end
