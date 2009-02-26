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

ActiveRecord::Schema.define(:version => 20090207213413) do

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "login"
    t.float    "skeleton_hours",        :default => 0.0
    t.float    "vacation_hours",        :default => 0.0
    t.float    "sick_hours",            :default => 0.0
    t.float    "comp_hours",            :default => 0.0
    t.float    "vacation_accrual_rate", :default => 0.0
    t.float    "sick_accrual_rate",     :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "work_periods", :force => true do |t|
    t.integer  "user_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
