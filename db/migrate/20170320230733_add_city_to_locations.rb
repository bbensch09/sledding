class AddCityToLocations < ActiveRecord::Migration[6.0]
  def change
        add_column :locations, :city, :string
        add_column :locations, :state_abbreviation, :string
  end
end
