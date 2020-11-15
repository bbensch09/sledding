class AddCityToInstructors < ActiveRecord::Migration[6.0]
  def change
        add_column :instructors, :city, :string
  end
end
