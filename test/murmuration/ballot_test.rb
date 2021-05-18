require './test/test_helper'

module Murmuration
  class BallotTest < Minitest::Test
    class DatabaseTest < ActiveSupport::TestCase
      context 'columns' do
        subject { FactoryBot.build(:ballot) }


        should have_db_column(:id).of_type(:integer).with_options(primary: true)
        should have_db_column(:created_at).of_type(:datetime)
        should have_db_column(:updated_at).of_type(:datetime)
      end

      context 'associations' do
        subject { FactoryBot.create(:ballot) }

        should belong_to(:question)
        should belong_to(:voting_entity)
        should validate_presence_of(:question).on(:create)
        should validate_presence_of(:voting_entity).on(:create)
      end
    end
  end
end

