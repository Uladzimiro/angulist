# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    group_id 1
    title 'Item title'
    priority 1
    complete_on "2014-03-21"
    completed false
    sort_order 1
  end
end
