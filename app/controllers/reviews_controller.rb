class ReviewsController < ApplicationController
	def new
		@review = Review.create(restaurant_id: @restaurant.id)
	end

end
