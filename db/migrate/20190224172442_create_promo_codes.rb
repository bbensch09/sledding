class CreatePromoCodes < ActiveRecord::Migration[6.0]
  def change
    create_table :promo_codes do |t|
      t.string :promo_code
      t.string :status
      t.float :discount
      t.string :discount_type
      t.integer :redemptions
      t.string :description
      t.boolean :single_use

      t.timestamps
    end
  end
end
