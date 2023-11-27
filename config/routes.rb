Rails.application.routes.draw do
 devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
 }
 devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
 }
 # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 root to: 'public/homes#top'
 get 'home/about'=>'public/homes#about'
 get '/genre/search' => 'public/searches#genre_search'



 scope module: :public do
  resources :items, only:[:index, :show]

  resource :customer, only: [:show, :update]do
   get 'information/edit' => 'customers#edit'
   get 'confirm' => 'customers#confirm'
   patch 'withdraw' => 'customers#withdraw'
   get 'mypage'=> 'customers#show'
  end

  resources :cart_items, only:[:index, :update, :destroy, :create]do
   collection do
    delete 'destroy_all'
   end
  end
  resources :orders, only: [:new, :create, :index, :show]do
   collection do
    post 'confirm'
    get 'confirm' => redirect('orders/new')
    # 注文情報入力画面でリロードされた場合GETメソッドが走るため、GETメソッドでURLが同じルーティングを作成。
    # このルーティングを通る場合は直接'orders/new'へリダイレクトされる。
    get 'complete'
   end

  end
  resources :addresses, only: [:index, :edit, :create, :update, :destroy]
 end

 get "admin" => 'admin/homes#top'
 namespace :admin do
  resources :items, only: [:index, :new, :create, :show, :edit, :update]
  resources :genres, only: [:index, :create, :edit, :update]
  resources :customers, only: [:index, :show, :edit, :update]
  resources :orders, only: [:show, :update]
  resources :order_details, only: [:update]
 end
end