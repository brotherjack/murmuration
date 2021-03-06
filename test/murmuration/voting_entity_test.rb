require './test/test_helper'

module Murmuration
  class VotingEntityTest < Minitest::Test
    class DatabaseTest < ActiveSupport::TestCase
      context 'columns' do
        subject { FactoryBot.build(:voting_entity) }

        should have_db_column(:id).of_type(:integer).with_options(primary: true)
        should have_db_column(:name).of_type(:string).with_options(null: false)
        should have_db_column(:public_key).of_type(:string).with_options(null: false)
        should have_db_column(:email).of_type(:string).with_options(null: true)
        should have_db_column(:created_at).of_type(:datetime)
        should have_db_column(:updated_at).of_type(:datetime)

        should validate_presence_of(:name)
        should validate_presence_of(:public_key)
        should validate_presence_of(:email).allow_nil
      end

      context 'associations' do
        subject { FactoryBot.build(:voting_entity) }

        should have_many(:ballots)
        should have_many(:questions)
      end
    end
  end
end
