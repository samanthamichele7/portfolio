# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin do
  	email "test@example.com"
  	password "password"
  	password_confirmation "password" 
  end
end
