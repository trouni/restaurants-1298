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
    @restaurants = Restaurant.all
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
      redirect_to restaurant_path(@restaurant)
    else
      # give the form back again -> new.html.erb
      render :new, status: :unprocessable_entity
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
