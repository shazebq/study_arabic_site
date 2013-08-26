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

ActiveRecord::Schema.define(:version => 20130826161833) do

  create_table "addresses", :force => true do |t|
    t.text     "address_line"
    t.integer  "city_id"
    t.integer  "country_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "answers", :force => true do |t|
    t.text     "content"
    t.integer  "forum_post_id"
    t.integer  "user_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "votes_count",    :default => 0
    t.boolean  "approved"
    t.integer  "comments_count"
  end

  add_index "answers", ["forum_post_id"], :name => "index_answers_on_forum_post_id"
  add_index "answers", ["user_id"], :name => "index_answers_on_user_id"

  create_table "articles", :force => true do |t|
    t.integer  "user_id"
    t.text     "title"
    t.text     "content"
    t.integer  "views_count"
    t.integer  "votes_count"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "comments_count"
    t.boolean  "approved"
    t.string   "thumbnail_url"
  end

  add_index "articles", ["user_id"], :name => "index_articles_on_user_id"
  add_index "articles", ["views_count"], :name => "index_articles_on_views_count"
  add_index "articles", ["votes_count"], :name => "index_articles_on_votes_count"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "category_parent_id"
  end

  add_index "categories", ["category_parent_id"], :name => "index_categories_on_category_parent_id"

  create_table "categories_categorizables", :force => true do |t|
    t.integer  "category_id"
    t.integer  "categorizable_id"
    t.string   "categorizable_type"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "categories_categorizables", ["categorizable_id", "categorizable_type"], :name => "catgories_join_index1"
  add_index "categories_categorizables", ["category_id", "categorizable_id"], :name => "categories_join_index2"

  create_table "centers", :force => true do |t|
    t.text     "name"
    t.text     "description"
    t.boolean  "short_term"
    t.boolean  "long_term"
    t.string   "website"
    t.string   "email"
    t.string   "phone_number"
    t.integer  "address_id"
    t.text     "program_length"
    t.integer  "user_id"
    t.boolean  "private_instruction"
    t.boolean  "group_instruction"
    t.integer  "year_established"
    t.decimal  "price_per_hour_private"
    t.decimal  "price_per_hour_group"
    t.decimal  "total_price"
    t.boolean  "housing_provided"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "reviews_count"
    t.boolean  "approved"
  end

  add_index "centers", ["address_id"], :name => "index_centers_on_address_id"
  add_index "centers", ["approved"], :name => "index_centers_on_approved"
  add_index "centers", ["reviews_count"], :name => "index_centers_on_reviews_count"
  add_index "centers", ["user_id"], :name => "index_centers_on_user_id"

  create_table "cities", :force => true do |t|
    t.text     "name"
    t.integer  "country_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "country_iso"
  end

  add_index "cities", ["country_id"], :name => "index_cities_on_country_id"

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.text     "content"
    t.boolean  "approved"
    t.integer  "comments_count"
  end

  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.string   "iso"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "degrees", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "forum_posts", :force => true do |t|
    t.text     "title"
    t.text     "content"
    t.integer  "views_count"
    t.integer  "votes_count"
    t.integer  "user_id"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "answers_count", :default => 0
    t.boolean  "approved"
  end

  add_index "forum_posts", ["answers_count"], :name => "index_forum_posts_on_answers_count"
  add_index "forum_posts", ["user_id"], :name => "index_forum_posts_on_user_id"
  add_index "forum_posts", ["views_count"], :name => "index_forum_posts_on_views_count"
  add_index "forum_posts", ["votes_count"], :name => "index_forum_posts_on_votes_count"

  create_table "images", :force => true do |t|
    t.string   "imageable_type"
    t.integer  "imageable_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "user_id"
  end

  add_index "images", ["user_id"], :name => "index_images_on_user_id"

  create_table "languages", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "levels", :force => true do |t|
    t.text     "title"
    t.text     "description"
    t.integer  "years_of_study"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "messages", :force => true do |t|
    t.text     "subject"
    t.text     "content"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.integer  "conversation_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.boolean  "sender_delete"
    t.boolean  "recipient_delete"
    t.boolean  "checked"
  end

  add_index "messages", ["recipient_id", "checked"], :name => "index_messages_on_recipient_id_and_checked"
  add_index "messages", ["recipient_id", "recipient_delete"], :name => "index_messages_on_recipient_id_and_recipient_delete"
  add_index "messages", ["sender_id", "sender_delete"], :name => "index_messages_on_sender_id_and_sender_delete"

  create_table "notifications", :force => true do |t|
    t.integer  "recipient_id"
    t.integer  "responsible_party_id"
    t.integer  "recipient_object_id"
    t.string   "recipient_object_type"
    t.integer  "responsible_party_object_id"
    t.string   "responsible_party_object_type"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "checked"
  end

  add_index "notifications", ["recipient_id", "checked"], :name => "index_notifications_on_recipient_id_and_checked"

  create_table "pg_search_documents", :force => true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "photos", :force => true do |t|
    t.integer  "photographable_id"
    t.string   "photographable_type"
    t.string   "photo_file"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "redactor_assets", :force => true do |t|
    t.integer  "user_id"
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "redactor_assets", ["assetable_type", "assetable_id"], :name => "idx_redactor_assetable"
  add_index "redactor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_redactor_assetable_type"

  create_table "resources", :force => true do |t|
    t.text     "title"
    t.text     "description"
    t.integer  "downloads_count"
    t.integer  "views_count"
    t.integer  "votes_count"
    t.integer  "user_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "resource_file_file_name"
    t.string   "resource_file_content_type"
    t.integer  "resource_file_file_size"
    t.datetime "resource_file_updated_at"
    t.integer  "reviews_count"
    t.boolean  "approved"
    t.integer  "level_id"
    t.boolean  "processing"
    t.string   "resource_file"
  end

  add_index "resources", ["downloads_count"], :name => "index_resources_on_downloads_count"
  add_index "resources", ["level_id"], :name => "index_resources_on_level_id"
  add_index "resources", ["user_id"], :name => "index_resources_on_user_id"
  add_index "resources", ["views_count"], :name => "index_resources_on_views_count"
  add_index "resources", ["votes_count"], :name => "index_resources_on_votes_count"

  create_table "reviews", :force => true do |t|
    t.text     "title"
    t.text     "content"
    t.integer  "rating"
    t.integer  "user_id"
    t.integer  "reviewable_id"
    t.string   "reviewable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.boolean  "approved"
  end

  add_index "reviews", ["reviewable_id", "reviewable_type"], :name => "index_reviews_on_reviewable_id_and_reviewable_type"
  add_index "reviews", ["user_id"], :name => "index_reviews_on_user_id"

  create_table "student_profiles", :force => true do |t|
    t.integer  "level_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "approved"
  end

  add_index "student_profiles", ["level_id"], :name => "index_student_profiles_on_level_id"

  create_table "teacher_profiles", :force => true do |t|
    t.boolean  "online"
    t.boolean  "in_person"
    t.integer  "years_of_experience"
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
    t.decimal  "price_per_hour",      :precision => 5, :scale => 2
    t.text     "specialties"
    t.text     "university"
    t.text     "field_of_study"
    t.integer  "reviews_count"
    t.boolean  "approved"
    t.text     "other_education"
    t.string   "gender"
    t.text     "employment_history"
    t.integer  "degree_id"
    t.integer  "city_id"
    t.string   "skype_id"
    t.date     "date_of_birth"
  end

  add_index "teacher_profiles", ["city_id"], :name => "index_teacher_profiles_on_city_id"
  add_index "teacher_profiles", ["degree_id"], :name => "index_teacher_profiles_on_degree_id"
  add_index "teacher_profiles", ["reviews_count"], :name => "index_teacher_profiles_on_reviews_count"

  create_table "teachers_languages", :force => true do |t|
    t.integer  "language_id"
    t.integer  "teacher_profile_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "teachers_languages", ["teacher_profile_id", "language_id"], :name => "index_teachers_languages_on_teacher_profile_id_and_language_id"

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
    t.integer  "reputation"
    t.text     "bio"
    t.integer  "profile_id"
    t.string   "profile_type"
    t.boolean  "admin"
    t.boolean  "staff_writer"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "username"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["country_id"], :name => "index_users_on_country_id"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["id", "admin"], :name => "index_users_on_id_and_admin"
  add_index "users", ["id", "staff_writer"], :name => "index_users_on_id_and_staff_writer"
  add_index "users", ["profile_id", "profile_type"], :name => "index_users_on_profile_id_and_profile_type"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "views", :force => true do |t|
    t.integer  "viewable_id"
    t.string   "viewable_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "session_id"
    t.string   "ip_address"
  end

  add_index "views", ["ip_address", "viewable_id", "viewable_type", "session_id"], :name => "views_unique_index"
  add_index "views", ["viewable_id", "viewable_type"], :name => "index_views_on_viewable_id_and_viewable_type"

  create_table "votes", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "voteable_id"
    t.string   "voteable_type"
  end

  add_index "votes", ["user_id", "voteable_id", "voteable_type"], :name => "votes_unique_index"
  add_index "votes", ["user_id"], :name => "index_votes_on_user_id"
  add_index "votes", ["voteable_id", "voteable_type"], :name => "index_votes_on_voteable_id_and_voteable_type"

end
