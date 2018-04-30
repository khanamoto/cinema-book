class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :user_name, limit: 100, null: false
      t.string :profile_name, null: false
      t.string :email, null: false
      t.string :password, null: false
      t.text :profile
      t.binary :user_image

      t.timestamps
    end
    add_index :users, :user_name, unique: true
    add_index :users, :email, unique: true
  end
end
