# spec/models/trip_spec.rb
require 'rails_helper'

RSpec.describe Trip, type: :model do
  # Validazioni di base
  it "is valid with valid attributes" do
    trip = Trip.new(
      trip_type: "round_trip",
      departure_airport_outbound: "JFK",
      arrival_airport_outbound: "LAX",
      departure_time_outbound: DateTime.now + 1.day,
      arrival_time_outbound: DateTime.now + 2.days,
      duration_outbound: 300,
      stop_count_outbound: 1,
      is_direct_outbound: false,
      total_price: 500.00,
      total_duration: 600,
      is_change_allowed: true,
      is_cancellation_allowed: false
    )
    expect(trip).to be_valid
  end

  it "is invalid without a departure airport" do
    trip = Trip.new(arrival_airport_outbound: "LAX")
    expect(trip).to_not be_valid
  end

  it "is invalid without a price" do
    trip = Trip.new(total_price: nil)
    expect(trip).to_not be_valid
  end
  
  

end
