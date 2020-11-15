class AddHowDidYouHearToInstructors < ActiveRecord::Migration[6.0]
  def change
      add_column :instructors, :how_did_you_hear, :string
  end
end
