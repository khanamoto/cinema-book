class User < ApplicationRecord
  has_many :films
  has_many :comments
  has_many :likes
  has_many :contacts
  has_many :follows

  mount_uploader :user_image, ImageUploader

  validates :user_name,
    presence: true,
    uniqueness: true,
    length: { in: 2..100 },
    format: { with: /\A[a-z]+[a-z_\d]*\z/ }

  validates :profile_name,
    length: { maximum: 255 }

  # 保存前にメールアドレスを小文字に変換する
  before_save { self.email = email.downcase }
  validates :email,
    presence: true,
    uniqueness: true,
    length: { maximum: 255 },
    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }

  has_secure_password
  validates :password,
    # コントローラーで定義したコンテキスト（:change_password）で検証する
    presence: { on: [ :create, :change_password ] },
    length: { minimum: 6, on: [ :create, :change_password ] }

  validates :agree,
    acceptance: { on: :create }
end
