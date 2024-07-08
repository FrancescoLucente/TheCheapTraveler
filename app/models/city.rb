class City < ApplicationRecord
  has_many :photos, dependent: :destroy

 

  def fetch_images_from_unsplash
    response = HTTParty.get("https://api.unsplash.com/search/photos", {
      query: {
        query: self.name,
        client_id: ENV['UNSPLASH_ACCESS_KEY'],
        per_page: 20
      }
    })

    if response.success?
      Rails.logger.info "Response from Unsplash API: #{response.body}"
      self.photos.destroy_all
      response['results'].each do |photo_data|
        self.photos.create!(image_url: photo_data['urls']['regular'])
      end
     
    
  end
end

