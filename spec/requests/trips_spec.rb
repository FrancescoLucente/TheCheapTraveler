require 'rails_helper'

RSpec.describe "Trips", type: :request do
  let(:trip1) {
    Trip.create!(
      trip_type: 'one_way',
      departure_airport_outbound: 'JFK',
      arrival_airport_outbound: 'LAX',
      departure_time_outbound: Time.now,
      arrival_time_outbound: Time.now + 5.hours,
      duration_outbound: 300,
      total_price: 150.00,
      is_direct_outbound: true,
      is_change_allowed: true,
      is_cancellation_allowed: true
    )
  }

  let(:trip2) {
    Trip.create!(
      trip_type: 'one_way',
      departure_airport_outbound: 'JFK',
      arrival_airport_outbound: 'SFO',
      departure_time_outbound: Time.now + 1.day,
      arrival_time_outbound: Time.now + 1.day + 6.hours,
      duration_outbound: 360,
      total_price: 200.00,
      is_direct_outbound: false,
      is_change_allowed: false,
      is_cancellation_allowed: false
    )
  }

  before do
    trip1
    trip2
  end

  
  describe "GET /trips" do
    it "ritorna una risposta di successo" do
      get trips_path
      expect(response).to have_http_status(:success)
    end

    it "assegna tutti i viaggi a @trips quando non ci sono filtri" do
      get trips_path
      expect(assigns(:trips)).to match_array([trip1, trip2])
    end

    context "quando si filtra per voli diretti" do
      it "ritorna solo i voli diretti" do
        get trips_path, params: { direct: 'yes' }
        expect(assigns(:trips)).to eq([trip1])
      end
    end

    context "quando si filtra per voli modificabili" do
      it "ritorna solo i voli con possibilità di modifica" do
        get trips_path, params: { flexible: 'yes' }
        expect(assigns(:trips)).to eq([trip1])
      end
    end

    context "quando si filtra per budget massimo" do
      it "ritorna solo i voli entro il budget specificato" do
        get trips_path, params: { budget: '160' }
        expect(assigns(:trips)).to eq([trip1])
      end

      it "non ritorna voli se nessuno rientra nel budget" do
        get trips_path, params: { budget: '100' }
        expect(assigns(:trips)).to be_empty
      end
    end

    context "quando si applicano più filtri contemporaneamente" do
      it "ritorna i voli che soddisfano tutti i criteri" do
        get trips_path, params: { direct: 'yes', flexible: 'yes', budget: '160' }
        expect(assigns(:trips)).to eq([trip1])
      end

      it "non ritorna voli se nessuno soddisfa tutti i criteri" do
        get trips_path, params: { direct: 'yes', budget: '10' }
        expect(assigns(:trips)).to be_empty
      end
    end

    context "quando si ordina i risultati" do
      it "ordina per prezzo totale in ordine crescente" do
        get trips_path, params: { sort: 'total_price' }
        expect(assigns(:trips)).to eq([trip1, trip2])
      end

      it "ordina per durata in ordine crescente" do
        get trips_path, params: { sort: 'duration_outbound' }
        expect(assigns(:trips)).to eq([trip1, trip2])
      end

      it "non ordina se il parametro sort non è valido" do
        get trips_path, params: { sort: 'invalid_column' }
        expect(assigns(:trips)).to match_array([trip1, trip2])
      end
    end
  end



  describe "POST /trips/search_trip (chiamata reale all'API)" do
    let(:valid_one_way_params) do
      {
        departure_city: 'Rome',
        destination_city: 'Paris',
        departure_date: '2024-12-01', 
        round_trip: 'no',
        number_of_people: '1',
        number_of_children: '0',
        number_of_infants: '0'
      }
    end

    let(:valid_round_trip_params) do
      valid_one_way_params.merge({
        round_trip: 'yes',
        return_date: '2024-12-10'
      })
    end

    context "quando si effettua una ricerca reale di sola andata" do
      it "crea un viaggio con la data di partenza corretta" do
       
        expect {
          post '/trips/search_trip', params: valid_one_way_params
        }.to change(Trip, :count).by_at_least(1) 

        trip = Trip.last
        expect(trip.departure_time_outbound.to_date.to_s).to eq('2024-12-01')
        expect(trip.trip_type).to eq('one_way')

        expect(response).to redirect_to(trips_path)
        follow_redirect!
        expect(response.body).to include('Ricerca completata!')
      end
    end

    context "quando si effettua una ricerca reale di andata e ritorno" do
      it "crea un viaggio con le date di partenza e ritorno corrette" do
        expect {
          post '/trips/search_trip', params: valid_round_trip_params
        }.to change(Trip, :count).by_at_least(1)

        trip = Trip.last
        expect(trip.departure_time_outbound.to_date.to_s).to eq('2024-12-01')
        expect(trip.departure_time_inbound.to_date.to_s).to eq('2024-12-10')
        expect(trip.trip_type).to eq('round_trip')

        expect(response).to redirect_to(trips_path)
        follow_redirect!
        expect(response.body).to include('Ricerca completata!')
      end
    end

    context "quando viene fornita una città non esistente" do
      it "reindirizza con un messaggio di avviso 'Città non trovata'" do
        post '/trips/search_trip', params: valid_one_way_params.merge({ departure_city: 'CittàInesistente12345' })

        expect(response).to redirect_to(trips_path)
        follow_redirect!
        expect(response.body).to include('Città non trovata')
      end
    end
  end
end

  


