class TripsController < ApplicationController
  before_action :set_trip, only: %i[ show edit update destroy ]

  require 'net/http'
  require 'json'
  # GET /trips or /trips.json
  
    def index
      if params[:departure_city].present? && params[:destination_city].present?
        @trips = search_trip(params)
        puts @trips.inspect # Debug: visualizza i risultati
      else
        @trips = []
      end
    end
  
  
  # GET /trips/1 or /trips/1.json
  def show
  end

  # GET /trips/new
  def new
    @trip = Trip.new
  end

  # GET /trips/1/edit
  def edit
  end

  # POST /trips or /trips.json
  def create
    @trip = Trip.new(trip_params)

    respond_to do |format|
      if @trip.save
        format.html { redirect_to trip_url(@trip), notice: "Trip was successfully created." }
        format.json { render :show, status: :created, location: @trip }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trips/1 or /trips/1.json
  def update
    respond_to do |format|
      if @trip.update(trip_params)
        format.html { redirect_to trip_url(@trip), notice: "Trip was successfully updated." }
        format.json { render :show, status: :ok, location: @trip }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trips/1 or /trips/1.json
  def destroy
    @trip.destroy!

    respond_to do |format|
      format.html { redirect_to trips_url, notice: "Trip was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search_trip(params)
    puts("inizio a cercare")
    departure_city = params[:departure_city]
    destination_city = params[:destination_city]
    departure_date = params[:departure_date]
    return_date = params[:return_date] if params[:round_trip] == 'yes'
    number_of_people = params[:number_of_people]
    number_of_children = params[:number_of_children]
    number_of_infants = params[:number_of_infants]
  
    departure_sky_id = get_sky_id(departure_city)
    
    destination_sky_id = get_sky_id(destination_city)
    puts "Sky ID Partenza: #{departure_sky_id}, Sky ID Destinazione: #{destination_sky_id}"


  
    return [] if departure_sky_id.nil? || destination_sky_id.nil?
  
    flights = []
    if params[:round_trip] == 'yes'
      flights = search_round_trip_flight(departure_sky_id, destination_sky_id, departure_date, return_date, number_of_people, number_of_children, number_of_infants)
    else
      flights = search_one_way_flight(departure_sky_id, destination_sky_id, departure_date, number_of_people, number_of_children, number_of_infants)
     

    end
  
    return [] if flights.empty?
    puts("inizio a creare le istanze")
    # Costruisci gli oggetti Trip in memoria senza salvarli nel DB
    trips = flights.map do |flight|
      outbound_leg = flight['legs'][0]
      trip = {
        trip_type: params[:round_trip] == 'yes' ? 'round_trip' : 'one_way',
        departure_airport_outbound: outbound_leg['origin']['name'],
        arrival_airport_outbound: outbound_leg['destination']['name'],
        departure_time_outbound: outbound_leg['departure'],
        arrival_time_outbound: outbound_leg['arrival'],
        duration_outbound: outbound_leg['durationInMinutes'],
        stop_count_outbound: outbound_leg['stopCount'],
        is_direct_outbound: outbound_leg['stopCount'] == 0,
        total_price: flight['price']['raw'],
        total_duration: outbound_leg['durationInMinutes'],
        is_change_allowed: flight['farePolicy']['isChangeAllowed'],
        is_cancellation_allowed: flight['farePolicy']['isCancellationAllowed']
      }
  
      if params[:round_trip] == 'yes'
        inbound_leg = flight['legs'][1]
        trip.merge!({
          departure_airport_inbound: inbound_leg['origin']['name'],
          arrival_airport_inbound: inbound_leg['destination']['name'],
          departure_time_inbound: inbound_leg['departure'],
          arrival_time_inbound: inbound_leg['arrival'],
          duration_inbound: inbound_leg['durationInMinutes'],
          stop_count_inbound: inbound_leg['stopCount'],
          is_direct_inbound: inbound_leg['stopCount'] == 0
        })
        trip[:total_duration] += inbound_leg['durationInMinutes']
      end
  
      trip
    end
  
    return trips
  end
  

  
    # Use callbacks to share common setup or constraints between actions.
    def set_trip
      @trip = Trip.find(params[:id])
    end
    

    # Only allow a list of trusted parameters through.
    def trip_params
      params.require(:trip).permit(:trip_type, :departure_airport_outbound, :arrival_airport_outbound, :departure_time_outbound, :arrival_time_outbound, :duration_outbound, :stop_count_outbound, :is_direct_outbound, :departure_airport_inbound, :arrival_airport_inbound, :departure_time_inbound, :arrival_time_inbound, :duration_inbound, :stop_count_inbound, :is_direct_inbound, :total_price, :total_duration, :is_change_allowed, :is_cancellation_allowed)
    end

    
      
  
    
    
     
    
      # Metodo per ottenere lo skyId di una città
      def get_sky_id(city_name)
        url = URI("https://sky-scanner3.p.rapidapi.com/flights/auto-complete?query=#{CGI.escape(city_name)}")
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        request = Net::HTTP::Get.new(url)
        request['x-rapidapi-host'] = 'sky-scanner3.p.rapidapi.com'
        request['x-rapidapi-key'] = '169b173a81msh1dd268500e59405p14d323jsn9b82494d8ac8'
    
        response = http.request(request)
        
        data = JSON.parse(response.body)
    
        # Ritorna il primo skyId disponibile
        return data['data'].first['navigation']['relevantFlightParams']['skyId'] rescue nil
      end
    
      # Metodo per cercare i voli con gli skyId ottenuti
      def search_one_way_flight(departure_sky_id, destination_sky_id, departure_date, adults, children, infants)
        base_url = "https://sky-scanner3.p.rapidapi.com/flights/search-one-way"
        
        # Costruzione dell'URL per il viaggio di sola andata
        url = URI("#{base_url}?fromEntityId=#{departure_sky_id}&toEntityId=#{destination_sky_id}&departDate=#{departure_date}&adults=#{adults}&children=#{children}&infants=#{infants}")
      
        # Richiesta HTTP
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        request = Net::HTTP::Get.new(url)
        request['x-rapidapi-host'] = 'sky-scanner3.p.rapidapi.com'
        request['x-rapidapi-key'] = '169b173a81msh1dd268500e59405p14d323jsn9b82494d8ac8'
      
        response = http.request(request)
        data = JSON.parse(response.body)
      
        # Restituisci i risultati dei voli, adattati alla tua struttura
        return data['data']['itineraries'] rescue []
      end

      def search_round_trip_flight(departure_sky_id, destination_sky_id, departure_date, return_date, adults, children, infants)
        base_url = "https://sky-scanner3.p.rapidapi.com/flights/search-roundtrip"
        
        # Costruzione dell'URL per il viaggio andata e ritorno
        url = URI("#{base_url}?fromEntityId=#{departure_sky_id}&toEntityId=#{destination_sky_id}&departDate=#{departure_date}&returnDate=#{return_date}&adults=#{adults}&children=#{children}&infants=#{infants}")
      
        # Richiesta HTTP
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        request = Net::HTTP::Get.new(url)
        request['x-rapidapi-host'] = 'sky-scanner3.p.rapidapi.com'
        request['x-rapidapi-key'] = '169b173a81msh1dd268500e59405p14d323jsn9b82494d8ac8'
      
        response = http.request(request)
        data = JSON.parse(response.body)
        puts "Risultati API One-Way: #{data.inspect}"

        # Restituisci i risultati dei voli, adattati alla tua struttura
        return data['data']['itineraries'] rescue []
      end
      
    
end
