class AddSlotToSections < ActiveRecord::Migration[6.0]
  def change
  	add_column :sections, :slot, :string
  end
end
