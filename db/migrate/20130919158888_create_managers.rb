class CreateManagers < ActiveRecord::Migration
  def up
    create_table :managers do |t|
      t.string      :name

      t.timestamps
    end
    
    Manager.create_translation_table!({
      name: :string
    })

    manager = Manager.new(
      name: 'Ambar', 
      user_attributes: { 
        email: 'admin@example.com', 
        password: 'password', 
        password_confirmation: 'password'
      }
    ) 
    user = manager.user
    user.skip_confirmation!
    user.save
    manager.save
  end

  def down
    drop_table :managers
    Manager.drop_translation_table!
  end
end
