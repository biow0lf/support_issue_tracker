FactoryGirl.define do
  factory :comment do
    ticket
    body { Faker::Lorem.paragraph }
    name { Faker::Name.name }
    email { Faker::Internet.email }

    factory :invalid_comment do
      email nil
    end
  end
end
