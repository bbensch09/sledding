class AddTermsFieldToLessonsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :lessons, :terms_accepted, :boolean
  end
end
