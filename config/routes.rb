Rails.application.routes.draw do
  root 'restaurants#index'
  devise_for :users
  resources :restaurants do
    resources :reviews, only: [:new, :create]
  end
  resources :reviews, only: [:destroy]
end


# get 'restaurants/:id/chef'
# get 'restaurants/top', to: 'restaurants#top', as: :top_restaurants

# NON-CRUD Routes
# collection -> all restaurants (aka no id)
# member     -> one restaurant (aka need id)

# do
#     collection do
#       get :top
#     end
#     member do
#       get :chef
#     end
#   end
