FactoryBot.define do
  factory :bike do
    code { Faker::Code.ean }
    available { true }

    association(:station)
  end
end