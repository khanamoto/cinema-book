class ChangeNameEmailNullOfContacts < ActiveRecord::Migration[5.2]
  def change
    change_column_null :contacts, :contact_name, false
    change_column_null :contacts, :contact_email, false
  end
end
