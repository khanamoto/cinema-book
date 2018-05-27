class ChangeDatatypeUserImageOfUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :user_image, :string
  end
end
