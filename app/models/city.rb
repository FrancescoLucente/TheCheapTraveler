class City < ApplicationRecord
  has_many :photos, dependent: :destroy
  has_many :events, dependent: :destroy
 

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
          start_time = DateTime.parse(event_data['start_time'])
          link=event_data['link']
          if event_data['end_time'].present?
              end_date = DateTime.parse(event_data['end_time'])
          else
            end_date = nil  # Oppure puoi gestire un valore di default o un altro comportamento qui
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
                              
        
end

