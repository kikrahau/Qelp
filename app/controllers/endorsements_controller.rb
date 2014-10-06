class EndorsementsController < ApplicationController
	include ActionView::Helpers::TextHelper
	
	def create
		if user_signed_in?
			review = Review.find(params[:review_id])
			restaurant = Restaurant.find(review.restaurant_id)
			if !review.endorsements.find_by(user_id: current_user.id).nil?
				render json: {new_endorsement_count: pluralize(review.endorsements.count, 'endorsement'), notice: "Can only endorse a review once" }
			elsif review.user_id == current_user.id
				render json: {new_endorsement_count: pluralize(review.endorsements.count, 'endorsement'), notice: "Can't endorse your own review" }
			else
				review.endorsements.create(user_id: current_user.id)
				render json: {new_endorsement_count: pluralize(review.endorsements.count, 'endorsement'), notice: "" }
			end
		else
			render json: {notice: "Please sign in, before endorsing a review." }
		end
	end

	def index
		create
	end
end
