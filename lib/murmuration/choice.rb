module Murmuration
  class Choice < ActiveRecord::Base
    self.table_name = 'choices'
    self.primary_key = 'id'

    belongs_to :question, dependent: :destroy, required: true
  end
end
