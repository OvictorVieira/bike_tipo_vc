FactoryBot.define do
  factory :station do
    name { 'Estação São Paulo' }
    latitude { -22.2232155 }
    longitude { -49.9879748 }
    vacancies { rand(1..1000) }
  end
end