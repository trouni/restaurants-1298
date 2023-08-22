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
    @restaurants = policy_scope(Restaurant)
  end

  def show
    # params is pulling the ID from the url
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant # this `#authorize` method checks if the user is allowed to view the @restaurant
  end

  def new
    # This is for the form
    @restaurant = Restaurant.new
    authorize @restaurant
  end

  # this does not have a view
  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user = current_user

    authorize @restaurant
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
    authorize @restaurant # @restaurant will be accessible as `record` in the policy
    
    # Without Pundit (for demo only):
    # raise 'AuthorizationError' unless @restaurant.user == current_user
  end

  # this does not have a view
  def update
    @restaurant = Restaurant.find(params[:id])
    
    authorize @restaurant # We want to make sure we check before we update
    if @restaurant.update(restaurant_params)
      redirect_to restaurant_path(@restaurant)
    else
      # give the form back again -> edit.html.erb
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant
    @restaurant.destroy
    redirect_to restaurants_path, status: :see_other
  end

  private

  # strong params -> white-listing the attributes a user can give me (for security reasons)
  def restaurant_params
    params.require(:restaurant).permit(:name, :rating, :address)
  end
end
