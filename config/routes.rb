Rails.application.routes.draw do
  
  resources :documents, only: [:index, :new, :create, :destroy]
  resources :pages, :except=>[:show]
  resources :settings, only: [:edit, :update]

  devise_for :users, :path=>"auth", :controllers=>{:registrations => :users}
  devise_scope :user do
    resources :users
  end
  root 'home#index'
  get 'page/:url' => 'home#index'
  get 'document/:url' => 'documents#url'
end
