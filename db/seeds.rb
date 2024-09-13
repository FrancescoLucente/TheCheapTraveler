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
  { name: 'Bangkok', country: 'Thailand', code: 'BKK', latitude: 13.7563, longitude: 100.5018 },
  { name: 'Paris', country: 'France', code: 'CDG', latitude: 48.8566, longitude: 2.3522 },
  { name: 'London', country: 'United Kingdom', code: 'LHR', latitude: 51.5074, longitude: -0.1278 },
  { name: 'Dubai', country: 'United Arab Emirates', code: 'DXB', latitude: 25.276987, longitude: 55.296249 },
  { name: 'Singapore', country: 'Singapore', code: 'SIN', latitude: 1.3521, longitude: 103.8198 },
  { name: 'New York', country: 'USA', code: 'JFK', latitude: 40.7128, longitude: -74.0060 },
  { name: 'Kuala Lumpur', country: 'Malaysia', code: 'KUL', latitude: 3.1390, longitude: 101.6869 },
  { name: 'Istanbul', country: 'Turkey', code: 'IST', latitude: 41.0082, longitude: 28.9784 },
  { name: 'Tokyo', country: 'Japan', code: 'NRT', latitude: 35.6762, longitude: 139.6503 },
  { name: 'Seoul', country: 'South Korea', code: 'ICN', latitude: 37.5665, longitude: 126.9780 },
  { name: 'Hong Kong', country: 'China', code: 'HKG', latitude: 22.3193, longitude: 114.1694 },
  { name: 'Barcelona', country: 'Spain', code: 'BCN', latitude: 41.3851, longitude: 2.1734 },
  { name: 'Amsterdam', country: 'Netherlands', code: 'AMS', latitude: 52.3676, longitude: 4.9041 },
  { name: 'Milan', country: 'Italy', code: 'MXP', latitude: 45.4642, longitude: 9.1900 },
  { name: 'Rome', country: 'Italy', code: 'FCO', latitude: 41.9028, longitude: 12.4964 },
  { name: 'Vienna', country: 'Austria', code: 'VIE', latitude: 48.2082, longitude: 16.3738 },
  { name: 'Shanghai', country: 'China', code: 'PVG', latitude: 31.2304, longitude: 121.4737 },
  { name: 'Las Vegas', country: 'USA', code: 'LAS', latitude: 36.1699, longitude: -115.1398 },
  { name: 'Madrid', country: 'Spain', code: 'MAD', latitude: 40.4168, longitude: -3.7038 },
  { name: 'Prague', country: 'Czech Republic', code: 'PRG', latitude: 50.0755, longitude: 14.4378 },
  { name: 'Los Angeles', country: 'USA', code: 'LAX', latitude: 34.0522, longitude: -118.2437 },
  { name: 'Orlando', country: 'USA', code: 'MCO', latitude: 28.5383, longitude: -81.3792 },
  { name: 'Miami', country: 'USA', code: 'MIA', latitude: 25.7617, longitude: -80.1918 },
  { name: 'San Francisco', country: 'USA', code: 'SFO', latitude: 37.7749, longitude: -122.4194 },
  { name: 'Dublin', country: 'Ireland', code: 'DUB', latitude: 53.3498, longitude: -6.2603 },
  { name: 'Toronto', country: 'Canada', code: 'YYZ', latitude: 43.6532, longitude: -79.3832 },
  { name: 'Vancouver', country: 'Canada', code: 'YVR', latitude: 49.2827, longitude: -123.1207 },
  { name: 'Cape Town', country: 'South Africa', code: 'CPT', latitude: -33.9249, longitude: 18.4241 },
  { name: 'Auckland', country: 'New Zealand', code: 'AKL', latitude: -36.8485, longitude: 174.7633 },
  { name: 'Sydney', country: 'Australia', code: 'SYD', latitude: -33.8688, longitude: 151.2093 },
  { name: 'Melbourne', country: 'Australia', code: 'MEL', latitude: -37.8136, longitude: 144.9631 },
  { name: 'Berlin', country: 'Germany', code: 'TXL', latitude: 52.5200, longitude: 13.4050 },
  { name: 'Munich', country: 'Germany', code: 'MUC', latitude: 48.1351, longitude: 11.5820 },
  { name: 'Zurich', country: 'Switzerland', code: 'ZRH', latitude: 47.3769, longitude: 8.5417 },
  { name: 'Geneva', country: 'Switzerland', code: 'GVA', latitude: 46.2044, longitude: 6.1432 },
  { name: 'Athens', country: 'Greece', code: 'ATH', latitude: 37.9838, longitude: 23.7275 },
  { name: 'Delhi', country: 'India', code: 'DEL', latitude: 28.6139, longitude: 77.2090 },
  { name: 'Mumbai', country: 'India', code: 'BOM', latitude: 19.0760, longitude: 72.8777 },
  { name: 'Beijing', country: 'China', code: 'PEK', latitude: 39.9042, longitude: 116.4074 },
  { name: 'Cairo', country: 'Egypt', code: 'CAI', latitude: 30.0444, longitude: 31.2357 },
  { name: 'Buenos Aires', country: 'Argentina', code: 'EZE', latitude: -34.6037, longitude: -58.3816 },
  { name: 'Rio de Janeiro', country: 'Brazil', code: 'GIG', latitude: -22.9068, longitude: -43.1729 },
  { name: 'Sao Paulo', country: 'Brazil', code: 'GRU', latitude: -23.5505, longitude: -46.6333 },
  { name: 'Lima', country: 'Peru', code: 'LIM', latitude: -12.0464, longitude: -77.0428 },
  { name: 'Moscow', country: 'Russia', code: 'SVO', latitude: 55.7558, longitude: 37.6173 },
  { name: 'Saint Petersburg', country: 'Russia', code: 'LED', latitude: 59.9343, longitude: 30.3351 },
  { name: 'Hanoi', country: 'Vietnam', code: 'HAN', latitude: 21.0285, longitude: 105.8542 },
  { name: 'Phuket', country: 'Thailand', code: 'HKT', latitude: 7.8804, longitude: 98.3923 }
]

cities.each do |city|
  City.find_or_create_by!(city)
  city.update(latitude: city[:latitude], longitude: city[:longitude])
end
