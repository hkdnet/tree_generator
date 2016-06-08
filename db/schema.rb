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

ActiveRecord::Schema.define(version: 20160608144532) do

  create_table "nodes", force: :cascade do |t|
    t.integer  "parent_node_id"
    t.string   "text"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["parent_node_id"], name: "index_nodes_on_parent_node_id"
  end

  create_table "trees", force: :cascade do |t|
    t.string   "title"
    t.string   "raw_text"
    t.integer  "root_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["root_id"], name: "index_trees_on_root_id"
  end

end
