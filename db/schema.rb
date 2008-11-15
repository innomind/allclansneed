# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20081115124006) do

  create_table "clans", :force => true do |t|
    t.string   "name",       :limit => 80
    t.integer  "site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clanwarmaps", :force => true do |t|
    t.string   "name"
    t.integer  "score"
    t.integer  "score_opponent"
    t.integer  "clanwar_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clanwars", :force => true do |t|
    t.string   "opponent"
    t.integer  "score"
    t.integer  "score_opponent"
    t.datetime "played_at"
    t.integer  "squad_id"
    t.integer  "site_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.string   "entry"
    t.integer  "site_id"
    t.integer  "user_id"
    t.integer  "news_id"
    t.integer  "guestbook_id"
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "gallery_pic_id"
  end

  create_table "forum_messages", :force => true do |t|
    t.text     "message"
    t.integer  "user_id"
    t.integer  "forum_thread_id"
    t.integer  "site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forum_threads", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.integer  "forum_id"
    t.integer  "site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forums", :force => true do |t|
    t.string   "title"
    t.string   "subtitle"
    t.integer  "position"
    t.integer  "parent_id"
    t.integer  "forum_threads_count"
    t.integer  "site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "galleries", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gallery_pics", :force => true do |t|
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.string   "pic_file_size"
    t.string   "name"
    t.text     "description"
    t.integer  "site_id"
    t.integer  "gallery_id"
    t.integer  "user_id"
    t.datetime "pic_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "guestbooks", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "entry"
    t.text     "comment"
    t.integer  "site_id"
    t.integer  "comment_author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.string   "subject"
    t.text     "message"
    t.boolean  "read"
    t.boolean  "answered"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news", :force => true do |t|
    t.string   "title"
    t.text     "subtext"
    t.text     "news"
    t.integer  "site_id"
    t.integer  "user_id"
    t.integer  "news_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news_categories", :force => true do |t|
    t.string   "name"
    t.integer  "site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news_comments", :force => true do |t|
    t.text     "comment"
    t.integer  "author_id"
    t.integer  "news_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pinwalls", :force => true do |t|
    t.string   "entry"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sites", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "squad_users", :force => true do |t|
    t.integer  "squad_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "squads", :force => true do |t|
    t.string   "name",       :limit => 80
    t.integer  "clan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string  "name"
    t.integer "site_id"
  end

  create_table "user_rights", :force => true do |t|
    t.integer  "site_id"
    t.integer  "user_id"
    t.integer  "level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "password",   :limit => 64
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
