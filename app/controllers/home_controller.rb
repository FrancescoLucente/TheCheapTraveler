
require 'uri'
class HomeController < ApplicationController
  def index
    @cities=City.all
  end

  

  

  def search_city
    # Logica per elaborare la ricerca della città
    city_name = params[:city_name]
   # Rails.logger.debug "Redirecting to: #{cities_path(query: city_name)}"
   redirect_to cities_path(query: city_name)

  end

  def suggest_cities
    # Logica per ottenere i suggerimenti delle città
    query = params[:query]
    @cities = City.where("name LIKE ?", "#{query}%").limit(5)

    respond_to do |format|
      format.json { render json: @cities.select(:id, :name) }
    end
  end
end
