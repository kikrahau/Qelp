require 'rails_helper'
require_relative '../helpers/application_helper'


describe 'endorsements' do 
	context 'endorsing reviews' do 
		before do 
			@restaurant = Restaurant.create(name: "Spitzweg")
			user = create(:user)	
		  	login_as(user, :scope => :user)
		  	leave_review('horrible stuff, will never eat there again',1)

		end

		it 'shows the endorsements of a review', js: true do 
			visit "/restaurants/#{@restaurant.id}"
			click_link 'Endorse'
			expect(page).to have_content("1 endorsements")
		end
	end
end