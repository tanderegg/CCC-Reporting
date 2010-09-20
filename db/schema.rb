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

ActiveRecord::Schema.define(:version => 20100917194411) do

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "abbreviation"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
  end

  create_table "report_field_groups", :force => true do |t|
    t.string   "title"
    t.string   "pos_x"
    t.string   "pos_y"
    t.string   "width"
    t.string   "height"
    t.string   "float"
    t.integer  "render_order"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.integer  "report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "report_fields", :force => true do |t|
    t.string   "label"
    t.integer  "size"
    t.string   "pos_x"
    t.string   "pos_y"
    t.string   "width"
    t.string   "height"
    t.integer  "report_field_group_id"
    t.integer  "report_field_type_id"
    t.integer  "report_master_field_id"
    t.string   "formula"
    t.string   "float"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "render_order"
  end

  create_table "report_submission_datas", :force => true do |t|
    t.integer  "report_submission_id"
    t.integer  "report_field_id"
    t.string   "value"
    t.text     "text_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "report_submissions", :force => true do |t|
    t.integer  "report_id"
    t.integer  "user_id"
    t.integer  "submission_type_id"
    t.date     "submission_date"
    t.text     "notes"
    t.boolean  "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reports", :force => true do |t|
    t.string   "name"
    t.boolean  "active"
    t.integer  "created_by"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "organization_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.integer  "login_count"
    t.integer  "failed_login_count"
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.string   "phonenumber"
    t.integer  "cel_user_id"
    t.integer  "organization_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
