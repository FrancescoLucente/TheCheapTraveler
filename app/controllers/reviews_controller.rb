class ReviewsController < ApplicationController


  # GET /reviews or /reviews.json
  def index
    @reviews = Review.all
  end

  # GET /reviews/1 or /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @city = City.find(params[:city_id])  # Cerca la città a cui associare la nuova recensione
    @review = @city.reviews.build
  end
  

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews or /reviews.json
  def create
    @city = City.find(params[:city_id])  # Cerca la città a cui si associa la recensione
    @review = @city.reviews.build(review_params)  # Crea la recensione associata alla città
    @review.user = current_user # Associa la recensione all'utente attuale

  
    respond_to do |format|
      if @review.save
        format.html { redirect_to city_url(@city), notice: "Recensione creata con successo." }
        format.json { render :show, status: :created, location: @review }
      else
        render :new
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end
  

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to review_url(@review), notice: "Review was successfully updated." }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    Rails.logger.debug "City ID: #{params[:city_id]}, Review ID: #{params[:id]}"
    @review=Review.find_by(id:params[:id])
    @city=City.find_by(id:params[:city_id])
    @review.destroy
    respond_to do |format|
      format.html { redirect_to city_path(@city), notice: 'Recensione eliminata con successo.' }
      format.json { head :no_content }
    end
  end
  

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = @city.reviews.find_by(id: params[:id])
      unless @review
        redirect_to city_path(@city), alert: 'Recensione non trovata.'
      end
    end
    

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:title, :content, :rating, :city_id)
    end
end
