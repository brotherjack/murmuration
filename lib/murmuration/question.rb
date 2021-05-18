require 'aasm'

module Murmuration
  class Question < ActiveRecord::Base
    include AASM
    include ActiveModel::Model

    self.table_name = 'questions'
    self.primary_key = 'id'

    has_many :votes,
             class_name: 'Murmuration::Ballot',
             dependent: :destroy
    belongs_to :asker,
               class_name: 'Murmuration::VotingEntity',
               foreign_key: 'asker_id'

    validates_associated :asker
    validates :name, presence: true
    validates :description, presence: true, allow_nil: true

    enum status: {
      formulating: 0,
      proposing: 1,
      considering: 2,
      decided: 3
    }

    aasm column: :status, enum: true, whiny_transitions: false do
      state :formulating, initial: true
      state :proposing, :considering, :decided

      after_all_transitions :notify_flock

      event :propose do
        transitions from: :formulating, to: :proposing
      end

      event :consider do
        transitions from: :proposing, to: :considering
      end

      event :decide do
        transitions from: :considering, to: :decided
      end

      event :reconsider do
        transitions from: :decided, to: :considering
      end
    end

    def notify_flock
    end
  end
end
