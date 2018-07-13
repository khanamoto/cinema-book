class Film < ApplicationRecord
  belongs_to :user
  has_many :film_tag
  has_many :tags, through: :film_tag
  accepts_nested_attributes_for :tags
  has_many :likes
  has_many :comments

  validates :user_id,
    presence: true

  validates :title,
    presence: true,
    length: { maximum: 255 }

  validates :staff,
    length: { maximum: 255 }

  validates :comment,
    presence: true,
    length: { maximum: 1000 }

  validates :cinema,
    length: { maximum: 100 }

  # 検索のクラスメソッドを定義する
  def self.search(word)
    if word
      # プレースホルダー(?)を使いキーワード検索する
      Film.where('title LIKE ?', "%#{sanitize_sql_like(word)}%")
    else
      Film.all
    end
  end
end
