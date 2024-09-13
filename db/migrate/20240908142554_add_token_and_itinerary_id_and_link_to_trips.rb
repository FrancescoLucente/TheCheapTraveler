class AddTokenAndItineraryIdAndLinkToTrips < ActiveRecord::Migration[7.1]
  def change
    add_column :trips, :token, :string
    add_column :trips, :itineraryId, :string
    add_column :trips, :link, :string
  end
end
