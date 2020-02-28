FactoryBot.define do
  factory :bike do
    code { Faker::Code.ean }

    association(:station)
  end
end