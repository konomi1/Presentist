require "google/cloud/translate/v2"

# 日本語に翻訳
module Translate
  class << self
    def to_ja(content)
      translate = Google::Cloud::Translate::V2.new(
        key: ENV['GOOGLE_API_KEY']
      )
      translation = translate.translate "#{content}", to: "ja"
      translation.text
    end
  end
end