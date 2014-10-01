def leave_review(content,rating)
	visit '/restaurants'
	click_link 'Spitzweg'
	click_link 'Leave Review'
	fill_in 'Content', with: content
	fill_in 'Rating', with: rating
	click_button 'Post Review'
end