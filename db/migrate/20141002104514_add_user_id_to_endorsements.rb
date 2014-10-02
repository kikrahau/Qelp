class AddUserIdToEndorsements < ActiveRecord::Migration
  def change
    add_reference :endorsements, :user, index: true
  end
end
