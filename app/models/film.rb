class Film < ApplicationRecord
  belongs_to :user
  has_many :films_tags
  has_many :tags, through: :films_tags
  has_many :likes
  has_many :comments
end
