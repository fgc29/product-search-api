FactoryBot.define do
  factory :inventory do
    association :product, factory: :product
    waist {Faker::Number.between(32, 38)}
    length {Faker::Number.between(28, 32)}
    style {Faker::Color.color_name}
    count {Faker::Number.between(0, 200)}
  end
end