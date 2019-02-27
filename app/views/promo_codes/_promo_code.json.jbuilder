json.extract! promo_code, :id, :promo_code, :status, :discount, :redemptions, :description, :single_use, :created_at, :updated_at
json.url promo_code_url(promo_code, format: :json)
