module RestaurantsHelper

	def star_rating(rating)
		if !rating.respond_to?(:round)
			"☆☆☆☆☆"
		else 
			"★"*rating.ceil + "☆"*(5-rating).floor
		end
	end
end
