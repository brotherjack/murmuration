# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_12_215701) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ballots", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "voting_entity_id"
    t.bigint "question_id"
    t.index ["question_id"], name: "index_ballots_on_question_id"
    t.index ["voting_entity_id"], name: "index_ballots_on_voting_entity_id"
  end

  create_table "choices", force: :cascade do |t|
    t.string "text", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "question_id"
    t.index ["question_id"], name: "index_choices_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.integer "status"
    t.string "name", null: false
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "asker_id"
    t.bigint "votes_id"
    t.index ["asker_id"], name: "index_questions_on_asker_id"
    t.index ["votes_id"], name: "index_questions_on_votes_id"
  end

  create_table "voting_entities", force: :cascade do |t|
    t.string "name", null: false
    t.string "public_key", null: false
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "questions_id"
    t.bigint "ballots_id"
    t.index ["ballots_id"], name: "index_voting_entities_on_ballots_id"
    t.index ["questions_id"], name: "index_voting_entities_on_questions_id"
  end

  add_foreign_key "ballots", "questions"
  add_foreign_key "ballots", "voting_entities"
  add_foreign_key "choices", "ballots", column: "question_id"
  add_foreign_key "questions", "ballots", column: "votes_id"
  add_foreign_key "questions", "voting_entities", column: "asker_id"
  add_foreign_key "voting_entities", "ballots", column: "ballots_id"
  add_foreign_key "voting_entities", "questions", column: "questions_id"
end
