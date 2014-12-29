class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.references :partner, index: true
      t.string :subject
      t.string :name
      t.string :email
      t.text :msg

      t.timestamps
    end
  end
end
