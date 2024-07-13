#class HomeController < ApplicationController
#  def index
#  end
#end

class HomeController < ApplicationController
  def index
    @cities=city.ApplicationController
  end

  def search_trip
    # Logica per elaborare la ricerca del viaggio
    departure_city = params[:departure_city]
    destination_city = params[:destination_city]
    departure_date = params[:departure_date]
    number_of_people = params[:number_of_people]
    round_trip = params[:round_trip]
    return_date = params[:return_date]

    # Esegui le azioni necessarie con questi dati
    redirect_to root_path, notice: "Trip search submitted!"
  end

  def search_city
    # Logica per elaborare la ricerca della città
    city_name = params[:city_name]

    # Esegui le azioni necessarie con questo dato
    redirect_to root_path, notice: "City search submitted!"
  end

  def suggest_cities
    # Logica per ottenere i suggerimenti delle città
    query = params[:query]
    @cities = City.where("name LIKE ?", "%#{query}%").limit(5)

    respond_to do |format|
      format.json { render json: @cities.pluck(:name) }
    end
  end
end