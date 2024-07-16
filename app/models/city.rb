require 'net/http'
require 'json'
require 'geocoder'

class City < ApplicationRecord
  has_many :photos, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :weathers, dependent: :destroy



  def fetch_images_from_unsplash
    response = HTTParty.get("https://api.unsplash.com/search/photos", {
      query: {
        query: self.name,
        client_id: ENV['UNSPLASH_ACCESS_KEY'],
        per_page: 20
      }
    })

    if response.success?
      self.photos.destroy_all
      response['results'].each do |photo_data|
        self.photos.create!(image_url: photo_data['urls']['regular'])
      end
     end

  end

    require 'uri'

    def fetch_events_from_rapidapi
      url = "https://real-time-events-search.p.rapidapi.com/search-events"
      query_params = {
        query: URI.encode_www_form_component(self.name)
      }

      headers = {
        "X-RapidAPI-Host" => "real-time-events-search.p.rapidapi.com",
        "X-RapidAPI-Key" => ENV['EVENTS_KEY']
      }

      response = HTTParty.get(url, query: query_params, headers: headers)

      if response.success?
        parsed_response = JSON.parse(response.body)
        events_data = parsed_response['data']

        self.events.destroy_all  # Elimina gli eventi esistenti

        events_data.each do |event_data|
          name = event_data['name']
          description = event_data['description']
          description=description.gsub(/[^a-zA-Z0-9\s.,&-]/, '')
          start_time = DateTime.parse(event_data['start_time'])
          link=event_data['link']
          if event_data['end_time'].present?
              end_date = DateTime.parse(event_data['end_time'])
          else
            end_date = nil
          end

          entity_id=event_data['event_id']

          event = self.events.new(
                                  entity_id:entity_id,
                                  name: name,
                                  description: description,
                                  event_date: start_time,
                                  end_date: end_date,
                                  link:link
          )

          event.save  # Salva l'evento nel database
        end
      else
        puts "Errore durante la richiesta all'API: #{response.code} - #{response.message}"
      end
   end

   def fetch_weather
    url = URI("https://ai-weather-by-meteosource.p.rapidapi.com/current?lat=#{self.latitude}&lon=#{self.longitude}&timezone=auto&language=en&units=auto")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["X-RapidAPI-Key"] = 'da03b8da1amshe251ccba685cddap18f4e9jsnd1f33d6c395a'  # Sostituisci con la tua chiave API
    request["X-RapidAPI-Host"] = 'ai-weather-by-meteosource.p.rapidapi.com'

    response = http.request(request)
    weather_data = JSON.parse(response.body)

    if response.is_a?(Net::HTTPSuccess)
      puts weather_data  # inserita per vedere l'intero dato ricevuto
      current_weather = weather_data['current']
      {
        temperature: current_weather['temperature'],
        description: current_weather['summary'],
        datetime: current_weather['time']  #
      }
    else
      { error: weather_data['message'] }
    end
  end





end


end
