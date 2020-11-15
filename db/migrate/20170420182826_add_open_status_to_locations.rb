class AddOpenStatusToLocations < ActiveRecord::Migration[6.0]
  def change
  	add_column :locations, :closing_date, :date
  end
end
