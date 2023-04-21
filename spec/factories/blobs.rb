# spec/factories/blobs.rb

FactoryBot.define do
  factory :blob do
    document_id { SecureRandom.uuid }
    document_filename { "#{document_id}.json" }
    data { { "example_key": "example_value" } }
  end
end
