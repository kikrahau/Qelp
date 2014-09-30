class Review < ActiveRecord::Base
	 belongs_to :restaurant
   validates :rating, presence: true, inclusion: { in: [1,2,3,4,5] }
end
