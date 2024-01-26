Rails.application.routes.draw do
  resources :songs
  resources :playlists
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  resource :playlist
  resource :song
end
