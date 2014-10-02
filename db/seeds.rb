# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Restaurant.destroy_all
Review.destroy_all
Endorsement.destroy_all

kfc = Restaurant.create(name: "KFC", description: "Shit food", cuisine:"Fast food", location: "London", price: 5 )
kfc.reviews.create(content: "Baaah food", rating: 1, user_id: 1)
kfc.reviews.create(content: "awesome", rating: 5, user_id: 2)


pret = Restaurant.create(name: "Pret", description: "Organic and expensive stuff", cuisine:"Fast food", location: "London", price: 10 )
pret.reviews.create(content: "Semi good food", rating: 3, user_id: 1)
pret.reviews.create(content: "Best food eeeeeeveeer", rating: 5, user_id: 2)

