class AddHdyhToLessons < ActiveRecord::Migration[6.0]
  def change
          add_column :lessons, :how_did_you_hear, :string
  end
end
