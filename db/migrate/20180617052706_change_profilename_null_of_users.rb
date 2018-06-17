class ChangeProfilenameNullOfUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :profile_name, true
  end
end
