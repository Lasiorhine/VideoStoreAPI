Rails.application.routes.draw do
  get 'movies/index'

  get 'movies/show'

  get 'movies/create'

	get '/zomg', to: 'application#zomg', as: 'zomg'
	resources :customers, only: :index
end
