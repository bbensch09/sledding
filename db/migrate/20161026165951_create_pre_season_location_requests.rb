class CreatePreSeasonLocationRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :pre_season_location_requests do |t|
      t.string :name

      t.timestamps
    end
  end
end
