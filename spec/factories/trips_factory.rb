FactoryBot.define do
  factory :trip do
    started_at { Time.now }
    finished_at { Time.now + 30.minutes }
    traveled_distance { rand(0.00..99.99) }

    association(:bike)
    association(:user)
  end
end