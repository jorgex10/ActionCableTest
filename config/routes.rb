Rails.application.routes.draw do

  mount ActionCable.server => '/cable'

  devise_for :users, controllers: { sessions: "sessions", registrations: "registrations" }

  root 'messages#index'

  resources :messages, only: [:index, :new, :create, :show] do
    collection do
      get :sent
      get :read
      get :unread
      get :starred
    end
    post :star, on: :member
  end
  resources :rooms, only: [:show, :create] do
    put :make_messages_as_read, on: :member
  end
  resources :users, only: :index

  get "avatar/:size/:background/:text" => Dragonfly.app.endpoint { |params, app|
    app.generate(:initial_avatar, URI.unescape(params[:text]), { size: params[:size], background_color: params[:background] })
  }, as: :avatar

end
