class RemoveStudentCountField < ActiveRecord::Migration[6.0]
  def change
    remove_column :lessons, :student_count, :integer
  end
end
