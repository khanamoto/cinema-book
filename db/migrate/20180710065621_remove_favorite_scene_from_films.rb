class RemoveFavoriteSceneFromFilms < ActiveRecord::Migration[5.2]
  def change
    remove_column :films, :favorite_scene
  end
end
