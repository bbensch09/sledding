class AddColumnsToProducts < ActiveRecord::Migration[6.0]
  def change
        add_column :products, :length, :string
        add_column :products, :slot, :string
        add_column :products, :start_time, :string
        add_column :instructors, :confirmed_certification, :string
  end
end
