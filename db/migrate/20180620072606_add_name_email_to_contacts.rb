class AddNameEmailToContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :contact_name, :string, after: :user_id
    add_column :contacts, :contact_email, :string, after: :contact_name
  end
end
