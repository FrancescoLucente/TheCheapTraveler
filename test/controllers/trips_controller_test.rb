require "test_helper"

class TripsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trip = trips(:one)
  end

  test "should get index" do
    get trips_url
    assert_response :success
  end

  test "should get new" do
    get new_trip_url
    assert_response :success
  end

  test "should create trip" do
    assert_difference("Trip.count") do
      post trips_url, params: { trip: { arrival_airport_inbound: @trip.arrival_airport_inbound, arrival_airport_outbound: @trip.arrival_airport_outbound, arrival_time_inbound: @trip.arrival_time_inbound, arrival_time_outbound: @trip.arrival_time_outbound, departure_airport_inbound: @trip.departure_airport_inbound, departure_airport_outbound: @trip.departure_airport_outbound, departure_time_inbound: @trip.departure_time_inbound, departure_time_outbound: @trip.departure_time_outbound, duration_inbound: @trip.duration_inbound, duration_outbound: @trip.duration_outbound, is_cancellation_allowed: @trip.is_cancellation_allowed, is_change_allowed: @trip.is_change_allowed, is_direct_inbound: @trip.is_direct_inbound, is_direct_outbound: @trip.is_direct_outbound, stop_count_inbound: @trip.stop_count_inbound, stop_count_outbound: @trip.stop_count_outbound, total_duration: @trip.total_duration, total_price: @trip.total_price, trip_type: @trip.trip_type } }
    end

    assert_redirected_to trip_url(Trip.last)
  end

  test "should show trip" do
    get trip_url(@trip)
    assert_response :success
  end

  test "should get edit" do
    get edit_trip_url(@trip)
    assert_response :success
  end

  test "should update trip" do
    patch trip_url(@trip), params: { trip: { arrival_airport_inbound: @trip.arrival_airport_inbound, arrival_airport_outbound: @trip.arrival_airport_outbound, arrival_time_inbound: @trip.arrival_time_inbound, arrival_time_outbound: @trip.arrival_time_outbound, departure_airport_inbound: @trip.departure_airport_inbound, departure_airport_outbound: @trip.departure_airport_outbound, departure_time_inbound: @trip.departure_time_inbound, departure_time_outbound: @trip.departure_time_outbound, duration_inbound: @trip.duration_inbound, duration_outbound: @trip.duration_outbound, is_cancellation_allowed: @trip.is_cancellation_allowed, is_change_allowed: @trip.is_change_allowed, is_direct_inbound: @trip.is_direct_inbound, is_direct_outbound: @trip.is_direct_outbound, stop_count_inbound: @trip.stop_count_inbound, stop_count_outbound: @trip.stop_count_outbound, total_duration: @trip.total_duration, total_price: @trip.total_price, trip_type: @trip.trip_type } }
    assert_redirected_to trip_url(@trip)
  end

  test "should destroy trip" do
    assert_difference("Trip.count", -1) do
      delete trip_url(@trip)
    end

    assert_redirected_to trips_url
  end
end
