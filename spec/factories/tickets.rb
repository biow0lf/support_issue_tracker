FactoryGirl.define do
  factory :ticket do
    status
    name { Faker::Name.name }
    email { Faker::Internet.email }
    summary { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
    department

    factory :invalid_ticket do
      email nil
    end
  end
end
