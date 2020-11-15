class AddProductNametoLessons < ActiveRecord::Migration[6.0]
  def change
  	add_column :lessons, :product_name, :string
  end
end
