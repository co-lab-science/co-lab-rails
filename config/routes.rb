Rails.application.routes.draw do
  resources :reviews
  root to: "static_page#home"

  get '/search', to: 'searches#search'

  scope '/admin' do
    resources :tags
    resources :users do
      resources :specialities
    end
  end

  resources :labs, as: 'observations', path: 'observations'
  resources :users
  resources :reviews
  resources :likes
  resources :votes
  resources :hypotheses
  resources :questions

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  get '/signup', to: 'users#new'
  get '/logout', to: 'sessions#destroy'
end
