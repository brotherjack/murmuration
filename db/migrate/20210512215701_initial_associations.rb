class InitialAssociations < ActiveRecord::Migration[6.0]
  def change
    change_table :ballots do |t|
      t.belongs_to :voting_entity, foreign_key: {to_table: :voting_entities}
      t.belongs_to :question, foreign_key: {to_table: :questions}
      # t.references :choices, 
      #              required: true,
      #              on_delete: :cascade,
      #              foreign_key: {to_table: :choices}
    end

    change_table :choices do |t|
      t.belongs_to :question,
                   on_delete: :cascade,
                   required: true,
                   foreign_key: {to_table: :ballots}
    end
    
    change_table :questions do |t|
      t.belongs_to :asker, foreign_key: {to_table: :voting_entities}
      t.references :votes, foreign_key: {to_table: :ballots}
    end
    
    change_table :voting_entities do |t|
      t.references :questions, foreign_key: {to_table: :questions}
      t.references :ballots, foreign_key: {to_table: :ballots }
    end
  end
end
