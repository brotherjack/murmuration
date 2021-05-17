require './lib/murmuration/choice'

FactoryBot.define do
  factory :choice, class: Murmuration::Choice do
    text { Faker::Books::Lovecraft.sentence }
  end
end
