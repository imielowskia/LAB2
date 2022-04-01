class AddGradeToCourseStudent < ActiveRecord::Migration[7.0]
  def change
    rename_table :courses_students, :course_students
    add_column :course_students, :grade, :integer
  end
end
