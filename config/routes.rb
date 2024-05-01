Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  root "homes#index"

  resource :session, only: %i[] do
    collection do
      get :login_form
      post :login
      post :logout
    end
  end

  resources :users, only: %i[create destroy]
  resources :messages, only: %i[index create]
  resources :groups, only: %i[create]
  resources :homes, only: %i[index]
end
