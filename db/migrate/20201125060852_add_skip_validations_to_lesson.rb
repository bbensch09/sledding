class AddSkipValidationsToLesson < ActiveRecord::Migration[6.0]
  def change
		add_column :lessons, :skip_validations, :boolean
  end
end
