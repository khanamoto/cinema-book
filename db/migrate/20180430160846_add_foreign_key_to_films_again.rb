class AddForeignKeyToFilmsAgain < ActiveRecord::Migration[5.2]
  def change
    add_reference :films, :user, foreign_key: true, after: :id
  end
end
