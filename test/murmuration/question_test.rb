require './test/test_helper'

module Murmuration
  class QuestionTest < Minitest::Test
    class DatabaseTest < ActiveSupport::TestCase
      context 'associations' do
        subject { FactoryBot.build :question }
        
        should belong_to(:asker).class_name(Murmuration::VotingEntity.name)
        should have_many(:votes).class_name(Murmuration::Ballot.name)
      end
      
      context 'columns' do
        subject { FactoryBot.build :question }
        
        should have_db_column(:id).of_type(:integer).with_options(primary: true)
        should have_db_column(:status).of_type(:integer)
        should have_db_column(:name).of_type(:string).with_options(null: false) 
        should have_db_column(:description).of_type(:string).with_options(null: true)
        should have_db_column(:created_at).of_type(:datetime)
        should have_db_column(:updated_at).of_type(:datetime)
      end
    end
    
    class StatusTest < QuestionTest 
      subject { FactoryBot.build :question }
      
      should define_enum_for(:status).
               with_values(
                           formulating: 0,
                           proposing: 1,
                           considering: 2, 
                           decided: 3
               )
    end
  end
end
