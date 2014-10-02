class EndorsementsController < ApplicationController
	include ActionView::Helpers::TextHelper
	
	def create
		review = Review.find(params[:review_id])
		restaurant = Restaurant.find(review.restaurant_id)
		endorsement = review.endorsements.new(user_id: current_user.id)
		unless endorsement.save
			flash[:notice] = "can't endorse your own review."
		end
		render json: {new_endorsement_count: pluralize(review.endorsements.count, 'endorsement') }
	end

end
