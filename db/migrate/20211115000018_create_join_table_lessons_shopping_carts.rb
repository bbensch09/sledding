class CreateJoinTableLessonsShoppingCarts < ActiveRecord::Migration[6.1]
  def change
    create_join_table :lessons, :shopping_carts do |t|
    end
  end
end
