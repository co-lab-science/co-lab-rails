Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  resources :groups
  get 'docs/about'

  get 'docs/privacy-policy'

  get 'docs/user-agreement'

  resources :reviews
  root to: "static_page#home"

  get '/privacy-policy', to: 'static_page#privacy'
  get '/user-agreement', to: 'static_page#agreement'
  get '/about', to: 'static_page#about'
  get '/help', to: 'static_page#help'
  get '/contact-us', to: 'static_page#contact'
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
  get '/auth/:github/callback', to: 'sessions#createOmni'
  # get '/auth/failure', to: 'sessions#failure'
  post '/login', to: 'sessions#create'
  get '/signup', to: 'users#new'
  get '/logout', to: 'sessions#destroy'
  post '/join-new-group', to: 'users#join_new_group'
end
