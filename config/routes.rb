Rails.application.routes.draw do
  namespace :public do
    get 'items/index'
    get 'items/show'
  end
  namespace :public do
    get 'homes/top'
    get 'homes/about'
  end
  namespace :admin do
    get 'homes/top'
  end
  namespace :admin do
    get 'order_details/update'
  end
  
  root 'public/homes#top'
  get '/about' => 'public/homes#about'
  devise_for :customers
  devise_for :admin
  resources :customers, only: [:show, :edit, :update] do
    member do
      get :unsubscribe
      patch :withdraw
    end
  end
  resources :items, only: [:index, :show]
  resources :cart_items, only: [:index, :create, :update, :destroy] do
     member do
      delete :destroy_all
    end
  end
  resources :orders, only: [:new, :show, :create, :index] do
   member do
      post :comfirm
      get :complete
    end
  end
  resources :addresses, only: [:index, :edit, :create, :update,:destroy]


  namespace:admin do
    get 'admin' => 'admin/homes#top'
    resources :customers, only: [:index, :show, :edit, :update]
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
    resources :genres, only: [:create, :index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end
end
