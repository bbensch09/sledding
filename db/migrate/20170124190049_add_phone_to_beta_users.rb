class AddPhoneToBetaUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :beta_users, :phone_number, :string
  end
end
