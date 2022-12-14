Rails.application.routes.draw do
  resources :styles
  resources :memberships do
    post 'confirm_membership', on: :member
  end
  resources :beer_clubs
  resources :users do
    post 'toggle_status', on: :member
  end
  resources :beers
  resources :breweries do 
    post 'toggle_activity', on: :member
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'breweries#index'

  # get 'ratings', to: 'ratings#index'
  # get 'ratings/new', to: 'ratings#new'
  # post 'ratings', to: 'ratings#create'
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'
  # Places
  resources :places, only: [:index, :show]
  post 'places', to: 'places#search'

  get 'beerlist', to: 'beers#list'
  get 'brewerylist', to: 'breweries#list'

  resource :session, only: [:new, :create, :destroy]

  resources :ratings, only: [:index, :new, :create, :destroy]
end
