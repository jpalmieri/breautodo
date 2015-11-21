Blocitoff::Application.routes.draw do
  devise_for :users

  root 'welcome#index'

  resources :todos, only: [:create, :index, :destroy]

  namespace :api do
    namespace :v1 do
      resources :todos, only: [:create, :index, :destroy]
    end
  end
end
