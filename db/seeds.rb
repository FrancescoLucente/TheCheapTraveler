# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

cities = [
  { name: 'Bangkok', country: 'Thailand', code: 'BKK' },
  { name: 'Paris', country: 'France', code: 'CDG' },
  { name: 'London', country: 'United Kingdom', code: 'LHR' },
  { name: 'Dubai', country: 'United Arab Emirates', code: 'DXB' },
  { name: 'Singapore', country: 'Singapore', code: 'SIN' },
  { name: 'New York', country: 'USA', code: 'JFK' },
  { name: 'Kuala Lumpur', country: 'Malaysia', code: 'KUL' },
  { name: 'Istanbul', country: 'Turkey', code: 'IST' },
  { name: 'Tokyo', country: 'Japan', code: 'NRT' },
  { name: 'Seoul', country: 'South Korea', code: 'ICN' },
  { name: 'Hong Kong', country: 'China', code: 'HKG' },
  { name: 'Barcelona', country: 'Spain', code: 'BCN' },
  { name: 'Amsterdam', country: 'Netherlands', code: 'AMS' },
  { name: 'Milan', country: 'Italy', code: 'MXP' },
  { name: 'Rome', country: 'Italy', code: 'FCO' },
  { name: 'Vienna', country: 'Austria', code: 'VIE' },
  { name: 'Shanghai', country: 'China', code: 'PVG' },
  { name: 'Las Vegas', country: 'USA', code: 'LAS' },
  { name: 'Madrid', country: 'Spain', code: 'MAD' },
  { name: 'Prague', country: 'Czech Republic', code: 'PRG' },
  { name: 'Los Angeles', country: 'USA', code: 'LAX' },
  { name: 'Orlando', country: 'USA', code: 'MCO' },
  { name: 'Miami', country: 'USA', code: 'MIA' },
  { name: 'San Francisco', country: 'USA', code: 'SFO' },
  { name: 'Dublin', country: 'Ireland', code: 'DUB' },
  { name: 'Toronto', country: 'Canada', code: 'YYZ' },
  { name: 'Vancouver', country: 'Canada', code: 'YVR' },
  { name: 'Cape Town', country: 'South Africa', code: 'CPT' },
  { name: 'Auckland', country: 'New Zealand', code: 'AKL' },
  { name: 'Sydney', country: 'Australia', code: 'SYD' },
  { name: 'Melbourne', country: 'Australia', code: 'MEL' },
  { name: 'Berlin', country: 'Germany', code: 'TXL' },
  { name: 'Munich', country: 'Germany', code: 'MUC' },
  { name: 'Zurich', country: 'Switzerland', code: 'ZRH' },
  { name: 'Geneva', country: 'Switzerland', code: 'GVA' },
  { name: 'Athens', country: 'Greece', code: 'ATH' },
  { name: 'Delhi', country: 'India', code: 'DEL' },
  { name: 'Mumbai', country: 'India', code: 'BOM' },
  { name: 'Beijing', country: 'China', code: 'PEK' },
  { name: 'Cairo', country: 'Egypt', code: 'CAI' },
  { name: 'Buenos Aires', country: 'Argentina', code: 'EZE' },
  { name: 'Rio de Janeiro', country: 'Brazil', code: 'GIG' },
  { name: 'Sao Paulo', country: 'Brazil', code: 'GRU' },
  { name: 'Lima', country: 'Peru', code: 'LIM' },
  { name: 'Moscow', country: 'Russia', code: 'SVO' },
  { name: 'Saint Petersburg', country: 'Russia', code: 'LED' },
  { name: 'Hanoi', country: 'Vietnam', code: 'HAN' },
  { name: 'Phuket', country: 'Thailand', code: 'HKT' }
]

cities.each do |city|
  City.find_or_create_by!(city)
end