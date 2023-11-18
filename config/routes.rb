Rails.application.routes.draw do
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
  resource :customer, only: [:update]do
    get 'mypage' => 'public/customers#show'
    get 'information/edit' => 'public/customers#edit'
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
