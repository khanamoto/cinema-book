class User < ApplicationRecord
  has_many :films
  has_many :comments
  has_many :likes
  has_many :contacts
  has_many :follows, foreign_key: 'user_id', dependent: :destroy

  # インスタンス変数の内容を外部から読み書きするため、アクセサメソッドを定義する
  attr_accessor :activation_token, :reset_token
  # 保存前にメールアドレスを小文字に変換する
  before_save { self.email = email.downcase }
  # 暗号化されたパスワード認証を追加する
  has_secure_password
  # 画像アップローダーを指定する
  mount_uploader :user_image, ImageUploader
  # オブジェクト作成前に有効化ダイジェストを作成する
  before_create :create_activation_digest

  validates :user_name,
    presence: true,
    uniqueness: true,
    length: { in: 2..100 },
    format: { with: /\A[a-z]+[a-z_\d]*\z/ }

  validates :profile_name,
    length: { maximum: 255 }

  validates :email,
    presence: true,
    uniqueness: true,
    length: { maximum: 255 },
    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }

  validates :password,
    # コントローラーで定義したコンテキスト（:change_password）で検証する
    presence: { on: [ :create, :change_password ] },
    length: { minimum: 6, on: [ :create, :change_password ] }

  validates :agree,
    acceptance: { on: :create }

  validates :profile,
    length: { maximum: 160 }

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # トークンがダイジェストと一致したらtrueを返す
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # パスワード再設定の属性を設定する
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # パスワード再設定のメールを送信する
  def send_password_reset_email
    NoticeMailer.password_reset(self).deliver_now
  end

  # パスワード再設定の期限が切れている場合はtrueを返す
  def password_reset_expired?
    reset_sent_at < 24.hours.ago
  end

  # アカウントを有効化する
  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # 有効化用のメールを送信する
  def send_activation_email
    NoticeMailer.account_activation(self).deliver_now
  end

  private
  # 有効化トークンとダイジェストを作成および代入する
  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
