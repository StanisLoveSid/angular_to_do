Rails.application.routes.draw do
  resources :sessions, only: [:create]
  resources :registrations, only: [:create]
  delete :logout, to: 'sessions#logout'
  get :logged_in, to: 'sessions#logged_in'
  post :facebook_login, to: 'sessions#facebook_login'

  resources :projects, only: [:index, :create, :update, :destroy], defaults: { format: 'json' }
  resources :tasks, only: [:create, :update, :destroy], defaults: { format: 'json' }
  resources :comments, only: [:create, :destroy, :update], defaults: { format: 'json' }

  put '/update_position', to: 'projects#update_position'
  put '/update_tasks_position', to: 'tasks#update_position'
end
