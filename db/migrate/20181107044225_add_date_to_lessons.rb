class AddDateToLessons < ActiveRecord::Migration[5.0]
  def change
	 add_column :lessons, :date, :date
  end
end
