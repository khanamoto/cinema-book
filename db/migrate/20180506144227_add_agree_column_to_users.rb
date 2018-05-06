class AddAgreeColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :agree, :boolean, null: false, after: :password
  end
end
