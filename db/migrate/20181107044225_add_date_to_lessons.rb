class AddDateToLessons < ActiveRecord::Migration[6.0]
  def change
	 add_column :lessons, :date, :date
  end
end
