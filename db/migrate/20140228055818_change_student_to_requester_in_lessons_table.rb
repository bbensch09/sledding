class ChangeStudentToRequesterInLessonsTable < ActiveRecord::Migration[6.0]
  def change
    rename_column :lessons, :student_id, :requester_id
  end
end
