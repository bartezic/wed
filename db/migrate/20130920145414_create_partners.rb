class CreatePartners < ActiveRecord::Migration
  def up
    create_table :partners do |t|
      t.string      :name
      t.text        :description
      t.text        :info
      t.integer     :price
      t.references  :location, index: true
      t.string      :site
      t.string      :phone
      t.boolean     :active
      t.boolean     :premium
      t.date        :premium_to
      t.attachment  :avatar
      t.string      :avatar_remote_url
      t.integer     :rating
      t.string      :slug

      # Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      # Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      # Rememberable
      t.datetime :remember_created_at

      # Trackable
      t.integer  :sign_in_count,  null: false, default: 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      t.timestamps
    end
    
    add_index :partners, :slug,                 unique: true
    add_index :partners, :email,                unique: true
    add_index :partners, :reset_password_token, unique: true
    
    Partner.create_translation_table!({
      name: :string,
      description: :text,
      info: :text
    })
  end
  def down
    remove_index :partners, :slug
    remove_index :partners, :email  
    remove_index :partners, :reset_password_token
    drop_table :partners
    Partner.drop_translation_table!
  end
end
