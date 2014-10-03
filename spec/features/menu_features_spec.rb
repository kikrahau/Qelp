require 'rails_helper'

describe 'menu ' do 
	it "each page has a homepage link" do 
		visit("/users/sign_up")
		expect(page).to have_link('Home')
	end 
	it "each page has a homepage link" do 
		visit("/users/sign_in")
		expect(page).to have_link('Home')
	end 
	it "each page has a homepage link" do 
		visit("/")
		expect(page).to have_link('Home')
	end 
end