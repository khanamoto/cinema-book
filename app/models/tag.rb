class Tag < ApplicationRecord
  has_many :films_tags
  has_many :films, through: :films_tags

  validates :tag_name, uniqueness: true
end
