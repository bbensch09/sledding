class CreateJoinTableSnowboardLevelInstructor < ActiveRecord::Migration[6.0]
  def change
        create_join_table :instructors, :snowboard_levels do |t|
        end
  end
end
