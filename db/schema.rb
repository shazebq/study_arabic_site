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

ActiveRecord::Schema.define(:version => 20130211184202) do

  create_table "animals", :force => true do |t|
    t.string   "name"
    t.integer  "weight"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "answers", :force => true do |t|
    t.text     "content"
    t.integer  "forum_post_id"
    t.integer  "user_id"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "votes_count",   :default => 0
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "category_parent_id"
  end

  create_table "categories_categorizables", :force => true do |t|
    t.integer  "category_id"
    t.integer  "categorizable_id"
    t.string   "categorizable_type"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "forum_posts", :force => true do |t|
    t.text     "title"
    t.text     "content"
    t.integer  "views_count"
    t.integer  "votes_count"
    t.integer  "user_id"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "answers_count", :default => 0
  end

  create_table "levels", :force => true do |t|
    t.text     "title"
    t.text     "description"
    t.integer  "years_of_study"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "resources", :force => true do |t|
    t.text     "title"
    t.text     "description"
    t.integer  "downloads_count"
    t.integer  "views_count"
    t.integer  "votes_count"
    t.integer  "difficulty_level"
    t.integer  "user_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "resource_file_file_name"
    t.string   "resource_file_content_type"
    t.integer  "resource_file_file_size"
    t.datetime "resource_file_updated_at"
    t.integer  "reviews_count"
  end

  create_table "reviews", :force => true do |t|
    t.text     "title"
    t.text     "content"
    t.integer  "rating"
    t.integer  "user_id"
    t.integer  "reviewable_id"
    t.string   "reviewable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "student_profiles", :force => true do |t|
    t.integer  "level_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "teacher_profiles", :force => true do |t|
    t.text     "education"
    t.boolean  "online"
    t.boolean  "in_person"
    t.integer  "years_of_experience"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
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
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "country_id"
    t.string   "skype_id"
    t.integer  "reputation"
    t.text     "bio"
    t.integer  "profile_id"
    t.string   "profile_type"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "views", :force => true do |t|
    t.integer  "viewable_id"
    t.string   "viewable_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "session_id"
    t.string   "ip_address"
  end

  create_table "votes", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "voteable_id"
    t.string   "voteable_type"
  end

end
