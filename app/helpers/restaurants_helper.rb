module RestaurantsHelper

	def star_rating(rating)
		if !rating.respond_to?(:round)
			"☆☆☆☆☆"
		else 
			"★"*rating.ceil + "☆"*(5-rating).floor
		end
	end

	def price_category_pound(price_category)
		if !price_category.is_a?(Integer)
			price_category
		else
			"£"*price_category
		end
	end
end
