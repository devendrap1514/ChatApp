Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  root "homes#index"

  resource :session, only: %i[] do
    collection do
      get :login_form
      post :login
      delete :logout
    end
  end

  resources :users, only: %i[create destroy]
  resources :messages, only: %i[index create]
  resources :groups, only: %i[index create] do
    resources :members, only: %i[index create]
  end
  resources :homes, only: %i[index]
  resources :chat_users, only: %i[index] do
    collection do
      get :search
    end
  end
end
