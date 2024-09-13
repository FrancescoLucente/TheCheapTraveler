class RemoveTokenAndItineraryIdFromTrips < ActiveRecord::Migration[7.1]
  def change
    remove_column :trips, :token, :string
    remove_column :trips, :itineraryId, :string
  end
end
