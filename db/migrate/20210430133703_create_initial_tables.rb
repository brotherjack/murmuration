class CreateInitialTables < ActiveRecord::Migration[6.0]
  def change
    #enable_extension 'pgcrypto' # only if UUID is a good idea?

    create_table :voting_entities do |t|
      t.string :name, null: false
      t.string :public_key, null: false
      t.string :email, null: true

      t.timestamps
    end

    create_table :questions do |t|
      t.integer :status
      t.string :name, null: false
      t.string :description, null: true

      t.timestamps
    end

    create_table :ballots do |t|
      t.timestamps
    end

    create_table :choices do |t|
      t.string :text, null: false

      t.timestamps
    end
  end
end
