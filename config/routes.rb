require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount ActionCable.server => '/cable'
  mount Sidekiq::Web => '/sidekiq'

  root "groups#index"

  resource :session, only: %i[] do
    collection do
      get :login_form
      post :login
      delete :logout
    end
  end

  resources :users, only: %i[create destroy]
  resources :messages, only: %i[index create]
  resources :groups, only: %i[index show create] do
    resources :members, only: %i[index create]
  end
  resources :posts, only: %i[index create]
end
