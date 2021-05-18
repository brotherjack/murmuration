require './lib/murmuration/ballot'

FactoryBot.define do
  factory :ballot, class: Murmuration::Ballot do
    before(:create) do |ballot, _|
      ballot.question ||= create(:question)
      ballot.voting_entity ||= create(:voting_entity)
    end
  end
end
