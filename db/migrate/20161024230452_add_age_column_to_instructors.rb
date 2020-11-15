class AddAgeColumnToInstructors < ActiveRecord::Migration[6.0]
  def change
    add_column :instructors, :age, :integer
    add_column :instructors, :dob, :date
  end
end
