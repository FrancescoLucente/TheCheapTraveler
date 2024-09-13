class Trip < ApplicationRecord
  validates_presence_of :departure_airport_outbound, :arrival_airport_outbound, :total_price, :duration_outbound
end
