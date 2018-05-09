Rails.application.routes.draw do

  resources :movies, only: [:index, :show, :create]

	get '/zomg', to: 'application#zomg', as: 'zomg'

	resources :customers, only: :index

  post '/rentals/check-out', to: 'rentals#checkout', as: 'checkout'
  post '/rentals/check-in', to: 'rentals#checkin', as: 'checkin'
  
end
