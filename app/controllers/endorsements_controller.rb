class EndorsementsController < ApplicationController
	
	def create
		review = Review.find(params[:review_id])
		restaurant = Restaurant.find(review.restaurant_id)
		review.endorsements.create
		render json: { new_endorsement_count: review.endorsements.count }
	end

end
