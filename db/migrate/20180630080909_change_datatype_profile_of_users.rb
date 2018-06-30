class ChangeDatatypeProfileOfUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :profile, :string, limit: 160
  end
end
