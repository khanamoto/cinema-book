class User < ApplicationRecord
  has_many :films
  has_many :comments
  has_many :likes
  has_many :contacts
  has_many :follows

  validates :user_name, uniqueness: true
  validates :email, uniqueness: true
end
