class RestaurantsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def top
    @restaurants = Restaurant.where(rating: 5)
  end

  def chef
    @restaurant = Restaurant.find(params[:id])
    # @chef_name = @restaurant.chef_name
  end

  def index
    @restaurant = Restaurant.new
    @restaurants = Restaurant.all

    @markers = @restaurants.geocoded.map do |restaurant|
      {
        lat: restaurant.latitude,
        lng: restaurant.longitude,
        popup_html: render_to_string(partial: "restaurants/map_popup", locals: { restaurant: restaurant }),
        marker_html: render_to_string(partial: "restaurants/map_marker", locals: { restaurant: restaurant })
      }
    end
  end

  def show
    # params is pulling the ID from the url
    @restaurant = Restaurant.find(params[:id])
  end

  def new
    # This is for the form
    @restaurant = Restaurant.new
  end

  # this does not have a view
  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      respond_to do |format|
        format.html { redirect_to restaurants_path }
        format.json { render json: {
          item_html: render_to_string(partial: 'restaurants/card', formats: :html, locals: { restaurant: @restaurant }),
          form_html: render_to_string(partial: 'restaurants/form', formats: :html, locals: { restaurant: Restaurant.new })
        } }
      end
    else
      respond_to do |format|
        format.html {render :new, status: :unprocessable_entity }
        format.json { render json: {
          form_html: render_to_string(partial: 'restaurants/form', formats: :html, locals: { restaurant: @restaurant })
        } }
      end
    end
  end

  def edit
    # This is for the form
    @restaurant = Restaurant.find(params[:id])
  end

  # this does not have a view
  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update(restaurant_params)
      redirect_to restaurant_path(@restaurant)
    else
      # give the form back again -> edit.html.erb
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    redirect_to restaurants_path, status: :see_other
  end

  private

  # strong params -> white-listing the attributes a user can give me (for security reasons)
  def restaurant_params
    params.require(:restaurant).permit(:name, :rating, :address)
  end
end
