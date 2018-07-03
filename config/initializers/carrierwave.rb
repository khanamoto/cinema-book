CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'

  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    region: ENV['AWS_REGION']
  }

  config.fog_directory = ENV['AWS_S3_BUCKET']
  config.asset_host = ENV['AWS_S3_URL']
  # キャッシュもS3に置く
  config.cache_storage = :fog

  # 日本語の文字化けを防ぐ
  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
end