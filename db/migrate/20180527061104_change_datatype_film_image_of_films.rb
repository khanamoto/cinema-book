class ChangeDatatypeFilmImageOfFilms < ActiveRecord::Migration[5.2]
  def change
    change_column :films, :film_image, :string
  end
end
