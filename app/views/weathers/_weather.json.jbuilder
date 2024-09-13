json.extract! weather, :id, :city_id, :temperature, :description, :datetime, :created_at, :updated_at
json.url weather_url(weather, format: :json)
