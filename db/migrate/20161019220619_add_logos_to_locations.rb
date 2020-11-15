class AddLogosToLocations < ActiveRecord::Migration[6.0]
  def self.up
    change_table :locations do |t|
      t.attachment :logo
    end
  end

  def self.down
    drop_attached_file :locations, :logo
  end
end
