class FilmTag < ApplicationRecord
  belongs_to :film, inverse_of: :films_tags
  belongs_to :tag, inverse_of: :films_tags
end
