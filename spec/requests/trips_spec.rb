require 'rails_helper'

RSpec.describe "Trips", type: :request do
  let(:valid_attributes) {
    {
      trip_type: 'one_way',
      departure_airport_outbound: 'JFK',
      arrival_airport_outbound: 'LAX',
      departure_time_outbound: Time.now,
      arrival_time_outbound: Time.now + 5.hours,
      duration_outbound: 300,
      total_price: 150.00,
      is_change_allowed: true,
      is_cancellation_allowed: true
    }
  }

  let(:invalid_attributes) {
    { trip_type: nil, departure_airport_outbound: nil }
  }

  let!(:trip) { Trip.create! valid_attributes }

  ### Test per l'azione INDEX ###
  describe "GET /trips" do
    it "ritorna una risposta di successo" do
      get trips_path
      expect(response).to have_http_status(:success)
    end

    it "assegna correttamente i viaggi a @trips" do
      get trips_path
      expect(assigns(:trips)).to include(trip)
    end

    it "filtra i voli diretti quando il parametro direct è 'yes'" do
      get trips_path, params: { direct: 'yes' }
      expect(assigns(:trips)).to all(have_attributes(is_direct_outbound: true))
    end
  end

  ### Test per l'azione SHOW ###
  describe "GET /trips/:id" do
    it "ritorna una risposta di successo per un trip esistente" do
      get trip_path(trip)
      expect(response).to have_http_status(:success)
    end

    it "mostra il viaggio richiesto" do
      get trip_path(trip)
      expect(assigns(:trip)).to eq(trip)
    end
  end

  ### Test per l'azione CREATE ###
  describe "POST /trips" do
    context "con attributi validi" do
      it "crea un nuovo viaggio" do
        expect {
          post trips_path, params: { trip: valid_attributes }
        }.to change(Trip, :count).by(1)
      end

      it "reindirizza al nuovo viaggio creato" do
        post trips_path, params: { trip: valid_attributes }
        expect(response).to redirect_to(Trip.last)
      end
    end

    context "con attributi non validi" do
      it "non crea un nuovo viaggio" do
        expect {
          post trips_path, params: { trip: invalid_attributes }
        }.to_not change(Trip, :count)
      end

      it "renderizza il template 'new'" do
        post trips_path, params: { trip: invalid_attributes }
        expect(response).to render_template("new")
      end
    end
  end

  ### Test per l'azione UPDATE ###
  describe "PATCH/PUT /trips/:id" do
    context "con attributi validi" do
      let(:new_attributes) {
        { total_price: 200.00 }
      }

      it "aggiorna il viaggio richiesto" do
        patch trip_path(trip), params: { trip: new_attributes }
        trip.reload
        expect(trip.total_price).to eq(200.00)
      end

      it "reindirizza al viaggio aggiornato" do
        patch trip_path(trip), params: { trip: new_attributes }
        expect(response).to redirect_to(trip)
      end
    end

    context "con attributi non validi" do
      it "non aggiorna il viaggio" do
        patch trip_path(trip), params: { trip: invalid_attributes }
        trip.reload
        expect(trip.total_price).to eq(valid_attributes[:total_price])
      end

      it "renderizza il template 'edit'" do
        patch trip_path(trip), params: { trip: invalid_attributes }
        expect(response).to render_template("edit")
      end
    end
  end

  ### Test per l'azione DESTROY ###
  describe "DELETE /trips/:id" do
    it "elimina il viaggio richiesto" do
      expect {
        delete trip_path(trip)
      }.to change(Trip, :count).by(-1)
    end

    it "reindirizza all'indice dei viaggi" do
      delete trip_path(trip)
      expect(response).to redirect_to(trips_path)
    end
  end
end
