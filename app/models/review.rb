class Review < ActiveRecord::Base
	 belongs_to :restaurant
	 belongs_to :user
	 has_many :endorsements

   validates :rating, presence: true, inclusion: (1..5)
   validates_uniqueness_of :user_id, message: "can't review a restaurant more than once."
end