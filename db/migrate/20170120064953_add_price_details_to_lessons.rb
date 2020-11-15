class AddPriceDetailsToLessons < ActiveRecord::Migration[6.0]
  def change
      add_column :lessons, :lesson_cost, :decimal
      add_column :lessons, :non_lesson_cost, :decimal
  end
end
