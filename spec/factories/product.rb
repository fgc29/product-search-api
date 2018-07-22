FactoryBot.define do
  factory :product do
    name {Faker::Name.name}
    image {Faker::Avatar.image}
    description {Faker::Lorem.paragraph(2)}
  end
end