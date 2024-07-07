# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
city=[
{:name => 'Bangkok', :country => 'Thailandia', :code => 'BKK'},
{:name => 'Parigi', :country => 'Francia', :code => 'CDG'},
{:name => 'Londra', :country => 'Regno Unito', :code => 'LHR'},
{:name => 'Dubai', :country => 'Emirati Arabi Uniti', :code => 'DXB'},
{:name => 'Singapore', :country => 'Singapore', :code => 'SIN'},
{:name => 'New York', :country => 'USA', :code => 'JFK'},
{:name => 'Kuala Lumpur', :country => 'Malesia', :code => 'KUL'},
{:name => 'Istanbul', :country => 'Turchia', :code => 'IST'},
{:name => 'Tokyo', :country => 'Giappone', :code => 'NRT'},
{:name => 'Seul', :country => 'Corea del Sud', :code => 'ICN'},
{:name => 'Hong Kong', :country => 'Cina', :code => 'HKG'},
{:name => 'Barcellona', :country => 'Spagna', :code => 'BCN'},
{:name => 'Amsterdam', :country => 'Paesi Bassi', :code => 'AMS'},
{:name => 'Milano', :country => 'Italia', :code => 'MXP'},
{:name => 'Roma', :country => 'Italia', :code => 'FCO'},
{:name => 'Vienna', :country => 'Austria', :code => 'VIE'},
{:name => 'Shanghai', :country => 'Cina', :code => 'PVG'},
{:name => 'Las Vegas', :country => 'USA', :code => 'LAS'},
{:name => 'Madrid', :country => 'Spagna', :code => 'MAD'},
{:name => 'Praga', :country => 'Repubblica Ceca', :code => 'PRG'},
{:name => 'Los Angeles', :country => 'USA', :code => 'LAX'},
{:name => 'Orlando', :country => 'USA', :code => 'MCO'},
{:name => 'Miami', :country => 'USA', :code => 'MIA'},
{:name => 'San Francisco', :country => 'USA', :code => 'SFO'},
{:name => 'Dublino', :country => 'Irlanda', :code => 'DUB'},
{:name => 'Toronto', :country => 'Canada', :code => 'YYZ'},
{:name => 'Vancouver', :country => 'Canada', :code => 'YVR'},
{:name => 'Città del Capo', :country => 'Sudafrica', :code => 'CPT'},
{:name => 'Auckland', :country => 'Nuova Zelanda', :code => 'AKL'},
{:name => 'Sydney', :country => 'Australia', :code => 'SYD'},
{:name => 'Melbourne', :country => 'Australia', :code => 'MEL'},
{:name => 'Berlino', :country => 'Germania', :code => 'TXL'},
{:name => 'Monaco di Baviera', :country => 'Germania', :code => 'MUC'},
{:name => 'Zurigo', :country => 'Svizzera', :code => 'ZRH'},
{:name => 'Ginevra', :country => 'Svizzera', :code => 'GVA'},
{:name => 'Atene', :country => 'Grecia', :code => 'ATH'},
{:name => 'Delhi', :country => 'India', :code => 'DEL'},
{:name => 'Mumbai', :country => 'India', :code => 'BOM'},
{:name => 'Pechino', :country => 'Cina', :code => 'PEK'},
{:name => 'Cairo', :country => 'Egitto', :code => 'CAI'},
{:name => 'Buenos Aires', :country => 'Argentina', :code => 'EZE'},
{:name => 'Rio de Janeiro', :country => 'Brasile', :code => 'GIG'},
{:name => 'San Paolo', :country => 'Brasile', :code => 'GRU'},
{:name => 'Lima', :country => 'Perù', :code => 'LIM'},
{:name => 'Mosca', :country => 'Russia', :code => 'SVO'},
{:name => 'San Pietroburgo', :country => 'Russia', :code => 'LED'},
{:name => 'Hanoi', :country => 'Vietnam', :code => 'HAN'},
{:name => 'Phuket', :country => 'Thailandia', :code => 'HKT'}
]
city.each do |citta|
    City.create(citta)
    end
