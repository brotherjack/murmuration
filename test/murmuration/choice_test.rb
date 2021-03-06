require './test/test_helper'

module Murmuration
  class ChoiceTest < Minitest::Test
    class DatabaseTest < ActiveSupport::TestCase
      context 'columns' do
        subject { FactoryBot.build :choice }

        should have_db_column(:id).of_type(:integer).with_options(primary: true)
        should have_db_column(:text).of_type(:string).with_options(null: false)
        should have_db_column(:created_at).of_type(:datetime)
        should have_db_column(:updated_at).of_type(:datetime)

        should validate_presence_of(:text).on(:create)
      end

      context 'associations' do
        subject { FactoryBot.build :choice}

        should belong_to(:question).required.dependent(:destroy)
        should validate_presence_of(:question).on(:create)
      end
    end
  end
end

