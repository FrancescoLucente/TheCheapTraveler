require 'rails_helper'

RSpec.describe "Cities", type: :request do
  # Creazione di città di esempio
  let!(:new_york) { City.create(name: "New York", country: "USA", code: "NYC") }
  let!(:los_angeles) { City.create(name: "Los Angeles", country: "USA", code: "LAX") }

  ### Test per l'azione INDEX ###
  describe "GET /cities" do
    it "ritorna una lista di tutte le città" do
      get cities_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include("New York")
      expect(response.body).to include("Los Angeles")
    end

    it "ritorna città che corrispondono alla query di ricerca" do
      get cities_path, params: { query: "New York" }
      expect(response.body).to include("New York")
      expect(response.body).to_not include("Los Angeles")
    end
  end

  ### Test per l'azione SHOW ###
  describe "GET /cities/:id" do
    it "mostra la città richiesta" do
      get city_path(new_york)
      expect(response).to have_http_status(:success)
      expect(response.body).to include("New York")
    end

    it "mostra un messaggio di errore se non riesce a recuperare i dati meteo" do
      allow_any_instance_of(City).to receive(:fetch_weather).and_return({ error: "Could not fetch weather data" })
      
      get city_path(new_york)
      expect(response.body).to include("Could not fetch weather data")
    end
  end
end
