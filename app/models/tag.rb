class Tag < ApplicationRecord
  has_many :film_tag
  has_many :films, through: :film_tag

  validates :tag_name, uniqueness: true
end
