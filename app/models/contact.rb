class Contact < ApplicationRecord
  belongs_to :user

  validates :contact_name,
    presence: true,
    length: { maximum: 255 }

  # 保存前にメールアドレスを小文字に変換する
  before_save { self.contact_email = contact_email.downcase }
  validates :contact_email,
    presence: true,
    length: { maximum: 255 },
    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }

  validates :body,
    presence: true
end
