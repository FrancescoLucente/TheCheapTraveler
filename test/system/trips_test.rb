require "application_system_test_case"

class TripsTest < ApplicationSystemTestCase
  setup do
    @trip = trips(:one)
  end

  test "visiting the index" do
    visit trips_url
    assert_selector "h1", text: "Trips"
  end

  test "should create trip" do
    visit trips_url
    click_on "New trip"

    fill_in "Arrival airport inbound", with: @trip.arrival_airport_inbound
    fill_in "Arrival airport outbound", with: @trip.arrival_airport_outbound
    fill_in "Arrival time inbound", with: @trip.arrival_time_inbound
    fill_in "Arrival time outbound", with: @trip.arrival_time_outbound
    fill_in "Departure airport inbound", with: @trip.departure_airport_inbound
    fill_in "Departure airport outbound", with: @trip.departure_airport_outbound
    fill_in "Departure time inbound", with: @trip.departure_time_inbound
    fill_in "Departure time outbound", with: @trip.departure_time_outbound
    fill_in "Duration inbound", with: @trip.duration_inbound
    fill_in "Duration outbound", with: @trip.duration_outbound
    check "Is cancellation allowed" if @trip.is_cancellation_allowed
    check "Is change allowed" if @trip.is_change_allowed
    check "Is direct inbound" if @trip.is_direct_inbound
    check "Is direct outbound" if @trip.is_direct_outbound
    fill_in "Stop count inbound", with: @trip.stop_count_inbound
    fill_in "Stop count outbound", with: @trip.stop_count_outbound
    fill_in "Total duration", with: @trip.total_duration
    fill_in "Total price", with: @trip.total_price
    fill_in "Trip type", with: @trip.trip_type
    click_on "Create Trip"

    assert_text "Trip was successfully created"
    click_on "Back"
  end

  test "should update Trip" do
    visit trip_url(@trip)
    click_on "Edit this trip", match: :first

    fill_in "Arrival airport inbound", with: @trip.arrival_airport_inbound
    fill_in "Arrival airport outbound", with: @trip.arrival_airport_outbound
    fill_in "Arrival time inbound", with: @trip.arrival_time_inbound
    fill_in "Arrival time outbound", with: @trip.arrival_time_outbound
    fill_in "Departure airport inbound", with: @trip.departure_airport_inbound
    fill_in "Departure airport outbound", with: @trip.departure_airport_outbound
    fill_in "Departure time inbound", with: @trip.departure_time_inbound
    fill_in "Departure time outbound", with: @trip.departure_time_outbound
    fill_in "Duration inbound", with: @trip.duration_inbound
    fill_in "Duration outbound", with: @trip.duration_outbound
    check "Is cancellation allowed" if @trip.is_cancellation_allowed
    check "Is change allowed" if @trip.is_change_allowed
    check "Is direct inbound" if @trip.is_direct_inbound
    check "Is direct outbound" if @trip.is_direct_outbound
    fill_in "Stop count inbound", with: @trip.stop_count_inbound
    fill_in "Stop count outbound", with: @trip.stop_count_outbound
    fill_in "Total duration", with: @trip.total_duration
    fill_in "Total price", with: @trip.total_price
    fill_in "Trip type", with: @trip.trip_type
    click_on "Update Trip"

    assert_text "Trip was successfully updated"
    click_on "Back"
  end

  test "should destroy Trip" do
    visit trip_url(@trip)
    click_on "Destroy this trip", match: :first

    assert_text "Trip was successfully destroyed"
  end
end
