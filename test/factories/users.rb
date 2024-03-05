# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { '' }
    sequence(:email) { |n| "sample-#{n}@example.com" }
    password { 'password' }
  end
end
