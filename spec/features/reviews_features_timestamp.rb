require 'rails_helper'
require 'timecop'

describe 'display timestamp' do
	before do 
		@restaurant = Restaurant.create(name: 'Spitzweg', description: 'This is an awesome restaurant')
		user = create(:user)	
  		login_as(user, :scope => :user)
	end

	it 'shows the time each review was posted' do
		Timecop.freeze(Time.new(2014))
		leave_review('wow', 4)
		Timecop.travel(1)
		visit "/restaurants/#{@restaurant.id}"
		expect(page).to have_content 'less than a minute ago'
	end

	it 'shows the time each review was posted' do
		Timecop.freeze(Time.new(2014))
		leave_review('wow', 4)
		Timecop.travel(1801)
		visit "/restaurants/#{@restaurant.id}"
		expect(page).to have_content '30 minutes ago'
	end
end