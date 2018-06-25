class AddResetToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :reset_digest, :string, after: :user_image
    add_column :users, :reset_sent_at, :datetime, after: :reset_digest
  end
end
