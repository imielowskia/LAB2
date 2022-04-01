class Student < ApplicationRecord
  belongs_to :group
  has_many :course_students
  has_many :courses, through: :course_students
  accepts_nested_attributes_for :course_students
end
