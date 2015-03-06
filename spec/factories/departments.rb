FactoryGirl.define do
  factory :department do
    name { Faker::Commerce.department }
  end
end
