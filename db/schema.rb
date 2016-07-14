# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160714151712) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "people", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "last_name_alt_spelling"
    t.string   "gender"
    t.date     "dob"
    t.string   "pob"
    t.boolean  "deceased?"
    t.date     "dod"
    t.string   "pod"
    t.text     "comments"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "people_unions", id: false, force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "union_id",  null: false
  end

  add_index "people_unions", ["person_id"], name: "index_people_unions_on_person_id", using: :btree
  add_index "people_unions", ["union_id"], name: "index_people_unions_on_union_id", using: :btree

  create_table "unions", force: :cascade do |t|
    t.date     "date"
    t.string   "location"
    t.boolean  "divorced?",  default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

end
