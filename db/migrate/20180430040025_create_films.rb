class CreateFilms < ActiveRecord::Migration[5.2]
  def change
    create_table :films do |t|
      t.string :title, null: false
      t.string :staff
      t.text :comment
      t.text :favorite_scene
      t.date :watch_day
      t.string :cinema, limit: 100
      t.binary :film_image

      t.timestamps
    end
  end
end
