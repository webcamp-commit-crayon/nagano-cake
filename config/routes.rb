Rails.application.routes.draw do
  root 'public/homes#top'
  get '/about' => 'public/homes#about'
  get '/admin' => 'admin/homes#top'
  devise_for :customers
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

  devise_for :admins
  namespace:admin do
    resources :customers, only: [:index, :show, :edit, :update]
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
    resources :genres, only: [:create, :index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end
end
