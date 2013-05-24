# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
  	admin_id 1
    name "Administrator"
    title "Title"
    content "Lorem Ipsum"
  end
end
