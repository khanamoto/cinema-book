RSpec.configure do |config|
  # テストコード内の名前空間（FactoryBot.）を省略する
  config.include FactoryBot::Syntax::Methods
end