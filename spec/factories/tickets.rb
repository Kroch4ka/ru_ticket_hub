FactoryBot.define do
  factory :ticket do
    title { Faker::Lorem.characters(number: 10) }
    body { Faker::Lorem.paragraphs(number: 1) }
    company
    creator { create(:user) }
  end
end
