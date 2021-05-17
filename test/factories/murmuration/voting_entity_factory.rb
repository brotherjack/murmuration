require './lib/murmuration/voting_entity'

FactoryBot.define do
  factory :voting_entity, class: Murmuration::VotingEntity do
    name { Faker::Creature::Bird.common_name.capitalize }
    public_key { OpenSSL::PKey::RSA.generate(2048) }
    email { Faker::Internet.email(name: name, domain: 'murmuration.org') }

    transient do
      questions_count { 0 }
    end

    questions do
      Array.new(questions_count) { association(:question) }
    end
  end
end
