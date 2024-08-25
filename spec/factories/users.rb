FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "password" }
    role { User::CUSTOMER_ROLE }

    trait :operator do
      role { User::OPERATOR_ROLE }
    end
  end
end
