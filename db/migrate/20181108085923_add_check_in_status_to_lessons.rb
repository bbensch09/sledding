class AddCheckInStatusToLessons < ActiveRecord::Migration[5.0]
  def change
  		 add_column :lessons, :check_in_status, :string
  end
end
