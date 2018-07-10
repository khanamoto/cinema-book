class ChangeStringCommentOfFilms < ActiveRecord::Migration[5.2]
  def change
    change_column :films, :comment, :string, limit: 200, null: false
  end
end
