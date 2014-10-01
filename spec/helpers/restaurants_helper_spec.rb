require 'rails_helper'

RSpec.describe RestaurantsHelper, :type => :helper do

	context 'star rating' do
		it 'should show 5 empty stars, when no reviews have been posted' do 
			expect(helper.star_rating('No reviews yet')).to eq "☆☆☆☆☆"
		end
		it 'should show 3 full stars, if it has an average rating of 3' do 
			expect(helper.star_rating(3)).to eq "★★★☆☆"
		end
		it 'rounds up to the nearest full number' do 
			expect(helper.star_rating(2.3)).to eq "★★★☆☆"
		end
	end

	context
end