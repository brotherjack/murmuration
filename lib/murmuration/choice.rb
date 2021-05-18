module Murmuration
  class Choice < ActiveRecord::Base
    include ActiveModel::Model

    self.table_name = 'choices'
    self.primary_key = 'id'

    belongs_to :question, dependent: :destroy, required: true

    validates :question, presence: true
  end
end
