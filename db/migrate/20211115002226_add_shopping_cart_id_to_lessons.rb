class AddShoppingCartIdToLessons < ActiveRecord::Migration[6.1]
  def change
  	    add_column :lessons, :shopping_cart_id, :integer
  end
end
