class CreateFilmTags < ActiveRecord::Migration[5.2]
  def change
    create_table :film_tags do |t|
      t.references :film, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end
