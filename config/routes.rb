Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'application#angular'

  resources :projects, only: [:index, :create, :update, :destroy], defaults: {format: 'json'}
  resources :tasks, only: [:create, :update, :destroy], defaults: {format: 'json'}
  resources :comments, only: [:create, :destroy, :update], defaults: {format: 'json'}

  put '/update_position', to: 'projects#update_position'
  put '/update_tasks_position', to: 'tasks#update_position'
end
