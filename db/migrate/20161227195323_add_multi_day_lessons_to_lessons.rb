class AddMultiDayLessonsToLessons < ActiveRecord::Migration[6.0]
  def change
      add_column :lessons, :num_days, :integer
      add_column :lessons, :lesson_price, :decimal
  end
end
