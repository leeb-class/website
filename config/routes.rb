Rails.application.routes.draw do
  
  resources :documents, only: [:index, :new, :create, :destroy]
  resources :pages, :except=>[:show]

  devise_for :users, :path=>"auth", :controllers=>{:registrations => :users}
  devise_scope :user do
    resources :users
  end
  root 'home#index'
  get 'pages/delete/:id' => 'pages#destroy'
  get 'users/delete/:id' => 'users#destroy'
  get 'documents/delete/:id' => 'documents#destroy'
  get 'page/:url' => 'home#index'
  get 'document/:url' => 'documents#url'
end
