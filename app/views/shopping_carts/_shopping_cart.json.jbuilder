json.extract! shopping_cart, :id, :status, :user_id, :transaction_id, :promotions, :admin_notes, :created_at, :updated_at
json.url shopping_cart_url(shopping_cart, format: :json)
