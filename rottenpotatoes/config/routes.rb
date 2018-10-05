Rottenpotatoes::Application.routes.draw do
  root 'movies#index'
  resources :movies
  # map '/' to be a redirect to '/movies'
  # root 'movies#index'
  # root :to => redirect('/index')
end
