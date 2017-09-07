Rails.application.routes.draw do
  root to: "static_page#home"

  get '/search', to: 'searches#search'

  get '/explore', to: "labs#index"
  post '/upload', to: "uploads#upload"
  post '/upload-file', to: "uploads#file_upload"

  scope '/admin' do
    resources :tags
    resources :users do
      resources :specialities
    end
  end

  resources :labs, as: 'observations', path: 'observations'
  resources :users
  resources :likes
  resources :votes
  resources :hypotheses
  resources :questions

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  get '/signup', to: 'users#new'
  get '/logout', to: 'sessions#destroy'
end
