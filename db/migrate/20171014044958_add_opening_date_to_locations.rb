class AddOpeningDateToLocations < ActiveRecord::Migration[6.0]
  def change
  	add_column :locations, :opening_date, :date
  end
end
