Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, only: [:show]
  resources :posts do
    resources :comments, only: [:create]
    resources :likes, only: [:create]
    resources :bookmarks, only: [:create]
  end
  resources :likes, only: [:destroy]
  resources :bookmarks, only: [:destroy]
  get '/get_inspired', to: 'pages#get_inspired'
  get '/playground', to: 'pages#playground'

  delete 'destroy_file', to: 'application#destroy_file', as: 'destroy_file' # for dropzone
end
