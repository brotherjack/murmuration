require 'active_record'

module Murmuration
  class Ballot < ActiveRecord::Base
    include ActiveModel::Model
    self.table_name = 'ballots'
    self.primary_key = 'id'

    belongs_to :voting_entity
    belongs_to :question

    validates :voting_entity, presence: true
    validates :question, presence: true
  end
end
