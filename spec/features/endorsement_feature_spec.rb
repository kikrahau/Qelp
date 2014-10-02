require 'rails_helper'
require_relative '../helpers/application_helper'


describe 'endorsements' do 
	context 'endorsing reviews' do 
		before do 
			@restaurant = Restaurant.create(name: "Spitzweg")
			user1 = create(:user1)	
		  	login_as(user1, :scope => :user)
		  	leave_review('horrible stuff, will never eat there again',1)
		end
		it 'shows 0 endorsements of a review, if not endorsed', js: true do 
			visit "/restaurants/#{@restaurant.id}"
			expect(page).to have_content("0 endorsements")
		end

		it 'shows 1 endorsement of a review, if endorsed once', js: true do 
			visit "/restaurants/#{@restaurant.id}"
			click_link 'Endorse'
			expect(page).to have_content("1 endorsement")
		end
		it 'shows 2 endorsements of a review, if endorsed twice', js: true do 
			visit "/restaurants/#{@restaurant.id}"
			click_link 'Endorse'
			user2 = create(:user2)
			login_as(user2, scope: :user)
			click_link 'Endorse'
			expect(page).to have_content("2 endorsements")
		end

		it 'can\'t endorse a review more than once', js: true do
			visit "/restaurants/#{@restaurant.id}"
			click_link 'Endorse'
			expect(page).to have_content("1 endorsement")
		end

	end
end