class CreateShoppingCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :shopping_carts do |t|
      t.string :status
      t.integer :user_id
      t.integer :transaction_id
      t.string :promotions
      t.text :admin_notes

      t.timestamps
    end
  end
end
