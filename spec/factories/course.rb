FactoryBot.define do
  factory :course do
    name { Faker::CryptoCoin.coin_name }
    association :coach
    transient do
      activity { build(:activity) }
    end
  end
end