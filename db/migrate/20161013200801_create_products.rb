class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.integer :location_id
      t.string :calendar_period

      t.timestamps
    end
  end
end
