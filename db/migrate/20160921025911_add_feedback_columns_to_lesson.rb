class AddFeedbackColumnsToLesson < ActiveRecord::Migration[6.0]
  def change
    add_column :lessons, :public_feedback_for_student, :string
    add_column :lessons, :private_feedback_for_student, :string
  end
end
