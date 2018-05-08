Rails.application.routes.draw do
	get '/zomg', to: 'application#zomg', as: 'zomg'
	resources  :customers, only: :show
end
