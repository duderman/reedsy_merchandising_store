# frozen_string_literal: true

FactoryBot.define do
  factory :store_item do
    code { 'MUG' }
    name { 'Reedsy Mug' }
    price { 6.0 }

    trait :tshirt do
      code { 'TSHIRT' }
      name { 'Reedsy T-Shirt' }
      price { 15.0 }
    end

    trait :hoodie do
      code { 'HOODIE' }
      name { 'Reedsy Hoodie' }
      price { 20.0 }
    end
  end
end
