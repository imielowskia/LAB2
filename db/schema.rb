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

ActiveRecord::Schema[7.0].define(version: 2022_04_01_200639) do
  create_table "course_students", id: false, force: :cascade do |t|
    t.integer "course_id", null: false
    t.integer "student_id", null: false
    t.integer "grade"
  end

  create_table "courses", force: :cascade do |t|
    t.string "nazwa"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses_groups", id: false, force: :cascade do |t|
    t.integer "course_id", null: false
    t.integer "group_id", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string "nazwa"
    t.integer "semestr"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.string "imie"
    t.string "nazwisko"
    t.string "indeks"
    t.integer "group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_students_on_group_id"
  end

  add_foreign_key "students", "groups"
end
