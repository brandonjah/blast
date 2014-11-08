FactoryGirl.define do
  factory :user do
    provider "twitter"
    sequence(:uid) { |n| "#{n}" }
    sequence(:name) { |n| "Person_#{n}" }
  end
end