class ChangeTextCommentOfFilms < ActiveRecord::Migration[5.2]
  def change
    change_column :films, :comment, :text, null: false
  end
end
