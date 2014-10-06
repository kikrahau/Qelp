require 'rails_helper'

describe 'menu ' do 
	it "each page has a homepage link - sign up" do 
		visit("/users/sign_up")
		expect(page).to have_link('Home')
	end 
	it "each page has a homepage link - sign in" do 
		visit("/users/sign_in")
		expect(page).to have_link('Home')
	end 
	it "each page has a homepage link - homepage" do 
		visit("/")
		expect(page).to have_link('Home')
	end 
end