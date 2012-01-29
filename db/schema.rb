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

ActiveRecord::Schema.define(:version => 20120122030931) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "attachments_count", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "friendly_id_slugs", :force => true do |t|
    t.string   "slug",                         :null => false
    t.integer  "sluggable_id",                 :null => false
    t.string   "sluggable_type", :limit => 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

  create_table "images", :force => true do |t|
    t.integer  "post_id"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "width"
    t.integer  "height"
    t.string   "camera_model"
    t.string   "exposure_time"
    t.string   "focal_length"
    t.float    "f_number"
    t.datetime "taken_at"
    t.string   "orientation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "featured",           :default => false
  end

  create_table "posts", :force => true do |t|
    t.integer  "category_id"
    t.string   "title"
    t.text     "body"
    t.boolean  "draft",                    :default => true
    t.integer  "images_count",             :default => 0
    t.string   "cover_image_file_name"
    t.string   "cover_image_content_type"
    t.integer  "cover_image_file_size"
    t.datetime "cover_image_updated_at"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "body_html"
    t.string   "slug"
  end

  add_index "posts", ["slug"], :name => "index_posts_on_slug"

end
