require 'rails_helper'

RSpec.describe City, type: :model do
  before(:all) do
    @city = City.create!(
      name: 'Rome',
      country: 'Italy',
      code: 'ROM',
      latitude: 41.9028,
      longitude: 12.4964
    )
  end

  after(:all) do
    @city.destroy
  end

  describe '#fetch_images_from_unsplash' do
    it 'retrieves images from Unsplash and creates photo records' do
      @city.fetch_images_from_unsplash

      expect(@city.photos.count).to be > 0
      expect(@city.photos.first.image_url).to be_present
    end
  end

  describe '#fetch_events_from_rapidapi' do
    it 'retrieves events from RapidAPI and creates event records' do
      @city.fetch_events_from_rapidapi

      expect(@city.events.count).to be > 0
      expect(@city.events.first.name).to be_present
      expect(@city.events.first.event_date).to be_present
    end
  end

  describe '#fetch_weather' do
    it 'retrieves current weather from Meteosource API' do
      weather = @city.fetch_weather

      expect(weather[:temperature]).to be_present
      expect(weather[:description]).to be_present
    end
  end
end
