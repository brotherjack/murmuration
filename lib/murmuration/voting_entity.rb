module Murmuration
  class VotingEntity < ActiveRecord::Base
    self.table_name = 'voting_entities'
    self.primary_key = 'id'

    has_many :ballots, class_name: 'Murmuration::Ballot'
    has_many :questions, class_name: 'Murmuration::Question', foreign_key: 'asker_id'

    validates_associated :ballots
    validates_associated :questions
    validates :name, presence: true
    validates :public_key, presence: true
    validates :email, presence: true, allow_nil: true
  end
end
