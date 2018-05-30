class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # ストレージの設定
  storage :file
  # S3用
  # storage :fog

  # 大きい画像を自動リサイズする
  process resize_to_fit: [500, 500]
  # サムネ画像のリサイズ
  # version :thumb do
  #   process resize_to_fit: [100, 162]
  # end

  # 保存ディレクトリを指定する
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # 拡張子を制限する
  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  # 画像サイズを制限する
  def size_range
    0..1.megabytes
  end

  # ファイル名が重複しないようユニーク名にする
  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  private
  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
end
