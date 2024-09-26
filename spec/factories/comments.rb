FactoryBot.define do
  factory :comment do
    description { Faker::Lorem.sentence }
    association :post
    association :user    
  end
end
