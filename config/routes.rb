Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'application#angular'

  resources :projects, only: [:index, :create, :update, :destroy]
  resources :tasks, only: [:create, :update, :destroy] do
    member do
      put '/reorder' => 'tasks#reorder'
    end
  end
  resources :comments, only: [:create, :destroy, :update]
end
