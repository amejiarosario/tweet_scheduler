# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    sequence(:message){ |n| "post test #{n}" }
    publish_on { Time.now }
  end
end
