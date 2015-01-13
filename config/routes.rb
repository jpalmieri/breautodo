Blocitoff::Application.routes.draw do
  devise_for :users

  get "welcome/index"

  root 'welcome#index'

  resources :todos, only: [:create, :index, :destroy]

  namespace :api do
    namespace :v1 do
      resources :todos, only: [:create, :index, :destroy]
    end
  end
end
