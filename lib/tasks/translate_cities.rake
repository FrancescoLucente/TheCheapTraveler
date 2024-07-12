namespace :translate do
  desc "Translate city names and countries to English"
  task cities: :environment do
    translations = {
      'Bangkok' => 'Bangkok', 'Thailandia' => 'Thailand',
      'Parigi' => 'Paris', 'Francia' => 'France',
      'Londra' => 'London', 'Regno Unito' => 'United Kingdom',
      'Dubai' => 'Dubai', 'Emirati Arabi Uniti' => 'United Arab Emirates',
      'Singapore' => 'Singapore', 'USA' => 'USA',
      'Kuala Lumpur' => 'Kuala Lumpur', 'Malesia' => 'Malaysia',
      'Istanbul' => 'Istanbul', 'Turchia' => 'Turkey',
      'Tokyo' => 'Tokyo', 'Giappone' => 'Japan',
      'Seul' => 'Seoul', 'Corea del Sud' => 'South Korea',
      'Hong Kong' => 'Hong Kong', 'Cina' => 'China',
      'Barcellona' => 'Barcelona', 'Spagna' => 'Spain',
      'Amsterdam' => 'Amsterdam', 'Paesi Bassi' => 'Netherlands',
      'Milano' => 'Milan', 'Italia' => 'Italy',
      'Roma' => 'Rome', 'Austria' => 'Austria',
      'Shanghai' => 'Shanghai', 'Las Vegas' => 'Las Vegas',
      'Madrid' => 'Madrid', 'Repubblica Ceca' => 'Czech Republic',
      'Los Angeles' => 'Los Angeles', 'Orlando' => 'Orlando',
      'Miami' => 'Miami', 'San Francisco' => 'San Francisco',
      'Dublino' => 'Dublin', 'Irlanda' => 'Ireland',
      'Toronto' => 'Toronto', 'Canada' => 'Canada',
      'Vancouver' => 'Vancouver', 'Città del Capo' => 'Cape Town',
      'Auckland' => 'Auckland', 'Nuova Zelanda' => 'New Zealand',
      'Sydney' => 'Sydney', 'Melbourne' => 'Melbourne',
      'Berlino' => 'Berlin', 'Germania' => 'Germany',
      'Monaco di Baviera' => 'Munich', 'Zurigo' => 'Zurich',
      'Ginevra' => 'Geneva', 'Grecia' => 'Greece',
      'Delhi' => 'Delhi', 'India' => 'India',
      'Mumbai' => 'Mumbai', 'Pechino' => 'Beijing',
      'Cairo' => 'Cairo', 'Egitto' => 'Egypt',
      'Buenos Aires' => 'Buenos Aires', 'Argentina' => 'Argentina',
      'Rio de Janeiro' => 'Rio de Janeiro', 'Brasile' => 'Brazil',
      'San Paolo' => 'Sao Paulo', 'Perù' => 'Peru',
      'Mosca' => 'Moscow', 'Russia' => 'Russia',
      'San Pietroburgo' => 'Saint Petersburg', 'Hanoi' => 'Hanoi',
      'Phuket' => 'Phuket'
    }

    translations.each do |original, translation|
      City.where(name: original).update_all(name: translation)
      City.where(country: original).update_all(country: translation)
    end
  end
end
