Rails.application.routes.draw do
  resources :users
  resources :beers
  resources :breweries
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'breweries#index'

  # get 'ratings', to: 'ratings#index'
  # get 'ratings/new', to: 'ratings#new'
  # post 'ratings', to: 'ratings#create'
  get 'signup', to: 'users#new'

  resource :session, only: [:new, :create, :destroy]

  resources :ratings, only: [:index, :new, :create, :destroy]
end
