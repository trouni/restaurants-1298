Rails.application.routes.draw do
  # http_verb '/path', to: 'controller#action', as: :prefix
  # the prefix ONLY refers to the path, not the http verb

  # CRUD

  # Read all -> index
  get '/restaurants', to: 'restaurants#index', as: :restaurants

  # Create -> 2 steps: form -> creation action
  # We need a page for the form
  get '/restaurants/new', to: 'restaurants#new', as: :new_restaurant
  post '/restaurants', to: 'restaurants#create' # already has a prefix

  # Read one -> show
  get '/restaurants/:id', to: 'restaurants#show', as: :restaurant

  # Update
  # We need a page for the form
  get '/restaurants/:id/edit', to: 'restaurants#edit', as: :edit_restaurant
  patch '/restaurants/:id', to: 'restaurants#update' # already has a prefix

  # Destroy
  delete '/restaurants/:id', to: 'restaurants#destroy' # already has a prefix

  # Create all 7 CRUD routes for you (but dont use in first app)
  # resources :restaurants
end
