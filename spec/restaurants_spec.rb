require 'rails_helper'

# >>> Debugging = save_and_open_page


describe 'restaurant' do 
	context 'without any restaurants created' do 
		it 'can prompt that there are no restaurants' do
			visit '/restaurants' 
			expect(page).to have_content('No restaurants')
			expect(page).to have_link('Create restaurant')
		end
	end
	context 'restaurants have been added' do 
		before do 
			Restaurant.create(name: 'Spitzweg', description: 'This is an awesome restaurant', rating: 5)
		end

		it 'shows one restaurant' do 
			visit '/restaurants'
			expect(page). to have_content('Spitzweg')
			expect(page).not_to have_content('No restaurants')
		end
	end

	context 'add restaurants' do 
		it 'should have a form' do 
			visit '/restaurants/new'
			expect(page).to have_css('form')
		end
	end

end