require 'faker'
require 'factory_bot'


include FactoryBot::Syntax::Methods

class User
  attr_accessor :first_name,
                :last_name,
                :email
end

class Company
  attr_accessor :company_name

end

class Car
  attr_accessor :manufacturer,
                :model_name,
                :have_brakes,
                :insurance_company,
                :insurance_policy_number,
                :owner
end

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.safe_email }
  end

  factory :car do
    manufacturer { Faker::Vehicle.manufacture }
    model_name { Faker::Vehicle.make }
    have_brakes { true }
    insurance_company { false }
    owner { false }

    trait :car_with_failures do
      have_brakes { false }
    end

    trait :insurance do
      insurance_company { Faker::Company.name }
      insurance_policy_number { Faker::Number.leading_zero_number(10) }
    end

    trait :owner do
      owner { Faker::Name.first_name }
    end

    factory :broken_car, traits: [:car_with_failures, :insurance]
    factory :car_owner, traits: [:car_with_failures, :owner]
  end


  factory :company , aliases: [:company_inc] do
    company_name { Faker::Company.name }
  end

end


p '#======================'
car = build(:car)
puts car.manufacturer
puts car.have_brakes
puts car.insurance_company

p '#======================'
broken_car = build(:broken_car)
puts broken_car.manufacturer
puts broken_car.have_brakes
puts broken_car.insurance_policy_number

p '#======================'
car_owner = build(:car_owner)
puts car_owner.manufacturer
puts car_owner.have_brakes
puts car_owner.owner
puts car.insurance_policy_number

p '#======================'
car = build(:car,{:manufacturer => 'Belatrix'})
puts car.manufacturer
puts car.have_brakes
puts car.insurance_company

p '#======================'
car_owner = build(:car_owner, :owner=>'alguien')
puts car_owner.manufacturer
puts car_owner.have_brakes
puts car_owner.owner

p '#======================'
company = build(:company_inc)
puts company.company_name
