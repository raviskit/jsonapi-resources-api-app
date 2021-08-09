FactoryBot.define do
  factory :activity do
    name { Faker::Hobby.activity }
    association :course
  end
end
