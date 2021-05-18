require './lib/murmuration/choice'

FactoryBot.define do
  factory :choice, class: Murmuration::Choice do
    text { Faker::Books::Lovecraft.sentence }

    before(:create) do |choice, _|
      choice.question ||= create(:question)
    end
  end
end
