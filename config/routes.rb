Rails.application.routes.draw do
  root 'users#index'


  get '/users/:id', to: 'users#show', as: 'user'
  get '/signup', to: 'users#new', as: 'new_user'
  post '/users', to: 'users#create'
  get '/users/:id/edit', to: 'users#edit', as: 'edit_user'
  patch '/users/:id', to: 'users#update'

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  get '/meds', to: 'meds#index', as: 'meds'
  get '/meds/:id', to: 'meds#show', as: 'med'
  get '/meds/new', to: 'meds#new', as: 'new_med'
  post '/meds', to: 'meds#create'

  get '/alerts', to: 'alerts#index', as: 'alerts'
  get '/alerts/:id', to: 'alerts#show', as: 'alert'
  get '/alerts/new', to: 'alerts#new', as: 'new_alert'
  post '/alerts', to: 'alerts#create'

end
