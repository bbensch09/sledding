class CreateInstructorsSportsJoinTable < ActiveRecord::Migration[6.0]
  def change
        create_join_table :instructors, :sports do |t|
        end
  end
end
