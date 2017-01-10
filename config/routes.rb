Rails.application.routes.draw do

  mount ActionCable.server => '/cable'

  devise_for :users

  root 'messages#index'

  resources :messages, only: [:index, :new, :create, :show] do
    collection do
      get :sent
      get :read
      get :unread
    end
  end

end
