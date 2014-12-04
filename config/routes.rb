Blocitoff::Application.routes.draw do
  devise_for :users

  get "welcome/index"

  root 'welcome#index'

  resources :todos, only: [:new, :create, :show, :index]

end
