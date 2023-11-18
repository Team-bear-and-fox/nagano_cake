Rails.application.routes.draw do
  get 'oreders/show'
  get 'customers/index'
  get 'customers/show'
  get 'customers/edit'
  get 'genres/index'
  get 'genres/edit'
  get 'items/index'
  get 'items/new'
  get 'items/show'
  get 'items/edit'
  get 'homes/top'
  get 'addresses/index'
  get 'addresses/edit'
  get 'orders/new'
  get 'orders/confirm'
  get 'orders/complete'
  get 'orders/index'
  get 'orders/show'
  get 'cart_items/index'
  get 'customers/show'
  get 'customers/edit'
  get 'customers/confirm'
  get 'customers/withdraw'
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'public/homes#top'
  resources :addresses, only: [:index, :edit, :create, :update, :destroy]

  resources :orders, only: [:new, :create, :index, :show]do
    collection do
      post 'confilm'
      get 'complete'
    end
  end
  resource :customer, only: [:show, :edit, :update]do

    get 'confilm'
    patch 'withdraw'
  end

  resources :cart_items, only:[:index, :update, :destroy_all, :create]do
    collection do
      delete 'destroy_all'
    end
  end

  resources :items, only:[:index, :show,]

  namespace :admin do
    get "admin" => 'homes#top'
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end
end
