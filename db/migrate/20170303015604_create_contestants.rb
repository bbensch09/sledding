class CreateContestants < ActiveRecord::Migration[6.0]
  def change
    create_table :contestants do |t|
      t.string :username
      t.string :hometown
      t.integer :user_id
      t.attachment :avatar

      t.timestamps
    end
  end
end
