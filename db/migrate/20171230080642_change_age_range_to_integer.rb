class ChangeAgeRangeToInteger < ActiveRecord::Migration[5.0]
  def change
  	add_column :students, :age, :integer
  end
end
