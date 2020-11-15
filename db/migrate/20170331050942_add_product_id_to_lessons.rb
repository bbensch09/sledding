class AddProductIdToLessons < ActiveRecord::Migration[6.0]
  def change
  	    add_column :lessons, :product_id, :integer
  end
end
