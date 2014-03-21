Angulist::Application.routes.draw do
  
  devise_for :users

  root 'home#index'

  namespace :api, defaults: { format: :json } do
    resources :items, only: [:index, :create, :update, :destroy]
    resources :groups, only: [:index, :create, :update, :destroy]
  end

end
