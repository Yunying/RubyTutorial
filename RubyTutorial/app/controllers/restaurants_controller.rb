class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user!

  # GET /restaurants
  # GET /restaurants.json
  def index
    @restaurants = current_user.restaurants
  end

  def addnote
    @note = Note.new(note_params)
    rid = @note.restaurant_id
    @restaurants = Restaurant.all
    @restaurant = @restaurants.find(rid)
    respond_to do |format|
      if @note.save
        format.html { redirect_to @restaurant, notice: 'Note was successfully created.' }
        format.json { render :show, location: @restaurant }
      else
        format.html { render :new }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  def searchyelp
    @restaurants = Restaurant.all
    @data = params[:text1]
    @response = Yelp.client.search("Seattle", {term: @data})
    @r = @response.businesses
    @r.each do |item|
      @business_name = item.location.address[0]
      @business_category = ""
      @categories = item.categories
      @categories.each do |category|
        @business_category = @business_category + category[1]+" "
      end
    end  
    @newitem = Restaurant.new
    @displaytext = "Search result for " + @data
  end

  def random
    @newnote = Note.new
    @restaurants = Restaurant.all
    random = Random.new
    @size = @restaurants.size
    rand = random.rand(@size)+1
    @choice = @restaurants.find(rand)
    rescue ActiveRecord::RecordNotFound => e
      @choice = @restaurants.find(2)
    @newitem = Restaurant.new
    
  end


  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
    @newnote = Note.new
    @restaurant = Restaurant.all.find(params[:id])
    @si = Note.all.size
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
  end

  def open_yelp
    redirected = false
    @restaurant = Restaurant.find(params[:id])
    @restaurants = Restaurant.all
    @response = Yelp.client.search('Seattle', { term: @restaurant.name })
    @list = @response.businesses
    @list.each do |item|
      if item.location.postal_code == @restaurant.zipcode
        redirected = true
        redirect_to item.url
        return
      end
    end

    if redirected == false
      redirect_to restaurants_path
    end
  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user_id = current_user.id

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully created.' }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /restaurants/1
  # PATCH/PUT /restaurants/1.json
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully updated.' }
        format.json { render :show, status: :ok, location: @restaurant }
      else
        format.html { render :edit }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    @restaurant.destroy
    respond_to do |format|
      format.html { redirect_to restaurants_url, notice: 'Restaurant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def restaurant_params
      params.require(:restaurant).permit(:name, :address, :tag, :zipcode)
    end

    def note_params
      params.require(:note).permit(:contect, :restaurant_id, :user_id)
    end
end
