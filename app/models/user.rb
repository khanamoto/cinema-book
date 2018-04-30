class User < ApplicationRecord
  validates :user_name, uniqueness: true
  validates :email, uniqueness: true
end
