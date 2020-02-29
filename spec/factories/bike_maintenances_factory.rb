FactoryBot.define do
  factory :bike_maintenance do
    reason { Faker::Lorem.characters }
    started_at { Time.now }
    finished_at { Time.now + 30.days }

    association(:bike)
  end
end
