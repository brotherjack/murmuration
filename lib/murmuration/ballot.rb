require 'active_record'

module Murmuration
  class Ballot < ActiveRecord::Base
    self.table_name = 'ballots'
    self.primary_key = 'id'

    belongs_to :voting_entity
    belongs_to :question
  end
end
