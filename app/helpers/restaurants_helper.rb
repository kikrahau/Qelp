module RestaurantsHelper

	def star_rating(rating)
		if rating == 'No reviews yet'
			"☆☆☆☆☆"
		else 
			"★"*rating.ceil + "☆"*(5-rating).floor
		end
	end
end
