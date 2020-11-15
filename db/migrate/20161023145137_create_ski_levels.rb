class CreateSkiLevels < ActiveRecord::Migration[6.0]
  def change
    create_table :ski_levels do |t|
      t.string :name
      t.integer :value

      t.timestamps
    end
  end
end
