class ShoppingCart < ApplicationRecord
	has_many :lessons
	has_many :products
	belongs_to :user

	def count_of_items
		total = 0
		# total += self.products.count
		total += self.lessons.count
	end

	def empty?
		return true if self.lessons.count == 0
	end

	def total_price
		total = 0
		self.lessons.each do |lesson|
			total += lesson.price.to_f
			puts "!!!!! DEBUG: lesson.price added to the cart total"
		end
		return total
	end

	def ready_to_book
		lessons_ready_to_book = []
		self.lessons.each do |lesson|
			if lesson.state = "ready_to_book"
				lessons_ready_to_book << lesson
			end
		end
		lessons_ready_to_book
	end

end
