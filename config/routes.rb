Angulist::Application.routes.draw do
  
  devise_for :users

  root 'home#index'

  namespace :api, defaults: { format: :json } do
    resources :groups, only: [:index, :show, :create, :update, :destroy]
    resources :items, only: [:index, :show, :create, :update, :destroy]
  end

end
