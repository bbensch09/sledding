class AddPriceDateToLocations < ActiveRecord::Migration[6.0]
  def change
          add_column :locations, :partner_status, :string
          add_column :locations, :calendar_status, :string
  end
end
