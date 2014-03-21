# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :group do
    user_id 1
    title 'group name'
    sort_order 1
  end
end
