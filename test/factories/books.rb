# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    sequence(:title) { |n| "サンプル本のタイトル-#{n}" }
    sequence(:memo) { |n| "サンプル本のメモ-#{n}" }
    sequence(:author) { |n| "サンプル本の著者-#{n}" }
    picture { Rack::Test::UploadedFile.new(Rails.root.join('test/fixtures/files/test.png').to_s) }
  end
end
