module Murmuration
  class VotingEntity < ActiveRecord::Base
    self.table_name = 'voting_entities'
    self.primary_key = 'id'

    has_many :ballots, class_name: 'Murmuration::Ballot'
    has_many :questions, class_name: 'Murmuration::Question', foreign_key: 'asker_id'
  end
end
