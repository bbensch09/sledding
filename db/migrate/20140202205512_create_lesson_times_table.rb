class CreateLessonTimesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :lesson_times do |t|
      t.date :date
      t.string :slot
    end
  end
end
