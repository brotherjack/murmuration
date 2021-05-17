require './lib/murmuration/question'

FactoryBot.define do
  factory :question, class: Murmuration::Question do
    status { 1 }
    name { Faker::Books::Lovecraft.sentence.gsub('.', '?') }
    description { Faker::Books::Lovecraft.paragraph }

    transient do
      ballots_count { 0 }
    end

    votes do
      Array.new(ballots_count) { association(:ballot) }
    end
    asker { association(:voting_entity) }
  end
end
