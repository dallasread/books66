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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121116030140) do

  create_table "books", :force => true do |t|
    t.string   "name"
    t.string   "permalink"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "abbr"
    t.integer  "chapters_count", :default => 0
    t.integer  "ordinal"
    t.string   "osis"
  end

  create_table "chapters", :force => true do |t|
    t.integer  "number"
    t.integer  "book_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "favourites", :force => true do |t|
    t.integer  "story_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "followships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "follow_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "items", :force => true do |t|
    t.string   "variation"
    t.integer  "item_id"
    t.string   "ref"
    t.integer  "ordinal"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "story_id"
  end

  create_table "lexicons", :force => true do |t|
    t.string   "code"
    t.string   "orig_word"
    t.string   "word_orig"
    t.string   "translit"
    t.string   "tdnt"
    t.string   "phonetic"
    t.string   "part_of_speech"
    t.text     "st_def"
    t.text     "ipd_def"
    t.string   "dictionary"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "lexicons", ["code"], :name => "index_lexicons_on_code"

  create_table "margins", :force => true do |t|
    t.string   "ref"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "position"
  end

  create_table "notes", :force => true do |t|
    t.integer  "story_id"
    t.integer  "user_id"
    t.text     "body"
    t.integer  "ordinal"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "position"
  end

  create_table "stories", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "permalink"
    t.text     "content"
  end

  create_table "translations", :force => true do |t|
    t.string   "name"
    t.string   "permalink"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "provider"
    t.string   "uid"
    t.string   "username"
    t.string   "name"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "verses", :force => true do |t|
    t.integer  "number"
    t.integer  "chapter_id"
    t.text     "body"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "translation_id"
    t.string   "ref"
  end

  add_index "verses", ["ref"], :name => "index_verses_on_ref"

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
