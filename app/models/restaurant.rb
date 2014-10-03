class Restaurant < ActiveRecord::Base
	has_many :reviews, dependent: :destroy
	
	validates :name, length: {minimum: 3}, uniqueness: true

	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

	def average_rating
		return 'No reviews yet' if reviews.none?
		reviews.average(:rating)
	end

	def price_category
		return 1 if (1..10).include?(price.to_i)
		return 2 if (11..20).include?(price.to_i)
		return 3 if (21..31).include?(price.to_i)
		return 4 if (32..100).include?(price.to_i)
		"No price category given"
	end
end
