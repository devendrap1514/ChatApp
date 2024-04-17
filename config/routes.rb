Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  resources :sessions, only: %i[] do
    collection do
      post :login
    end
  end

  resources :users, only: %i[create destroy]
  resources :messages, only: %i[index create]
  resources :chat_users, only: %i[index]

  post '/webhooks/calendly', to: 'webhooks#calendly'
end
