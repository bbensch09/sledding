class CreateLessonActions < ActiveRecord::Migration[6.0]
  def change
    create_table :lesson_actions do |t|
      t.integer :lesson_id
      t.integer :instructor_id
      t.string :action

      t.timestamps
    end
  end
end
