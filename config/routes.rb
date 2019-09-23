Rails.application.routes.draw do
  root 'feeds#index'
  get 'sessions/new'
  resources :feeds do
    collection do
      post :confirm
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
end