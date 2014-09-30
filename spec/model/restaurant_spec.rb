require 'rails_helper'

RSpec.describe Restaurant, type: :model do 
	it 'is not valid with a name of less than 3 characters' do 
		restaurant = Restaurant.new(name: "Et")
		expect(restaurant).to have(1).error_on(:name)
	end

	it 'is not valid when it already exists' do 
		Restaurant.create(name: "Ethel's café")
		restaurant = Restaurant.new(name: "Ethel's café")
		expect(restaurant).to have(1).error_on(:name)
	end
end