class AddStateToLessonsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :lessons, :state, :string
  end
end
