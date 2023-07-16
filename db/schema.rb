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

ActiveRecord::Schema[7.0].define(version: 2022_09_26_035108) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "posts", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "tagline"
    t.string "pricing_type"
    t.integer "comments"
    t.integer "reviews"
    t.decimal "rating"
    t.integer "votes"
    t.integer "product_id"
    t.integer "topic_ids", array: true
    t.boolean "dws"
    t.datetime "feature_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: :cascade do |t|
    t.string "slug"
    t.integer "post_ids", array: true
  end

  create_table "topics", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.integer "parent_id"
    t.integer "posts_count"
    t.integer "followers_count"
    t.integer "real_posts"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "headline"
    t.string "twitter"
    t.string "website"
    t.boolean "is_viewer"
    t.boolean "is_maker"
    t.boolean "is_trashed"
    t.integer "badges"
    t.integer "followers"
    t.integer "following"
    t.integer "score"
    t.integer "maker_ids", array: true
    t.integer "hunter_ids", array: true
    t.integer "commenter_ids", array: true
    t.integer "upvoter_ids", array: true
    t.datetime "created_at"
  end

end
