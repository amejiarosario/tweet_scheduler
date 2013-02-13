# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    message "MyText"
    publish_on "2013-02-13 00:08:04"
  end
end
