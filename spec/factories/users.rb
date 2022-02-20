# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:name)  { |n| "NAME#{n}" }
    sequence(:email) { |n| "TEST#{n}@example.com" }
    password         { 'aaaaAAAA1111' }
    password_confirmation { 'aaaaAAAA1111' }
    age              { 20 }
    gender           { 1 }
    association :company
  end
end
