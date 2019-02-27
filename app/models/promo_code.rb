class PromoCode < ApplicationRecord
	has_many :lessons

def valid_redemptions
	count = Lesson.where(promo_code_id:self.id,state:'confirmed').count
end	
end
