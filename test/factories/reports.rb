# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    association :user
    title { 'Aliceの日報' }
    content { 'Aliceの日報の本文' }
  end
end
