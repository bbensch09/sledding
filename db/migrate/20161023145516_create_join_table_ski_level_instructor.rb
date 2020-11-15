class CreateJoinTableSkiLevelInstructor < ActiveRecord::Migration[6.0]
  def change
        create_join_table :instructors, :ski_levels do |t|
        end
  end
end
