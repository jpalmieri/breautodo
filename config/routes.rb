Blocitoff::Application.routes.draw do
  get "about/index"
  devise_for :users

  root 'welcome#index'

  resources :todos, only: [:create, :index, :destroy]
  resources :lists

  namespace :api do
    namespace :v1 do
      resources :todos, only: [:create, :index, :destroy]
    end
  end
end
