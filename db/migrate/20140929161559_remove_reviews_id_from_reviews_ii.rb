class RemoveReviewsIdFromReviewsIi < ActiveRecord::Migration
  def change
  	remove_column :reviews, :reviews_id
  end
end
