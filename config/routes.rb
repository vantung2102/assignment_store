Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'

  devise_for :users,
              path: '',
              path_names: { sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'register' },
              controllers: { omniauth_callbacks: "omniauth_callbacks" }
  
  # User
  devise_scope :user do 
    get 'register', to: 'devise/registrations#new'
    get 'login', to: 'devise/sessions#new'
    get 'logout', to: 'devise/sessions#destroy'
  end

  # scope '(:locale)', locale: /en|vi/ do
    # Admin
    namespace :admin do
      get '/', to: 'home#index'
      resources :brands
      resources :categories
      resources :vouchers
      delete 'users/:id/delete', to: 'users#destroy'
      resources :products do
        post 'edit_product', to: 'products#edit_product'
      end
      post 'products/show_attribute', to: 'products#show_attribute'
      post 'products/show_attribute2', to: 'products#show_attribute2'
      post 'products/show_no_attribute', to: 'products#show_no_attribute'
      resources :users
      resources :orders
      post 'orders/submit', to: 'orders#submit'
      post 'orders/cancel', to: 'orders#cancel'
      post 'orders/success', to: 'orders#success'
    end

    # Client
    get 'category/:slug', to: 'home#change_category'
    get 'brand/:slug', to: 'home#change_brand'
    get 'product/load_more', to: 'home#load_more_product'
    get 'search/:keyword', to: 'home#search'
    
    resources :product_detail, only: [ :show ] do
      get '/:slug', to: 'product_detail#show'
    end

    resources :comments do
      post 'reply_comment', to: 'comments#reply_comment'
    end

    resource :cart, only: [:show] do
      get 'show_cart', to: 'cart#show'
      get 'select_attribute', to: 'cart#select_attribute'
      get 'check_amount', to: 'cart#check_amount'
    end

    resource :checkout do
      post 'payment', to: 'checkouts#payment'
      get '/stripe', to: 'checkouts#stripe_payment'
      post '/payment_with_stripe', to: 'checkouts#payment_with_stripe'
      post '/create_order_stripe', to: 'checkouts#create_order_stripe'
      post '/payment_with_momo', to: 'checkouts#payment_with_momo'
      get '/success', to: 'checkouts#success'
      get '/error', to: 'checkouts#error'
      post '/info_checkout', to: 'checkouts#info_checkout'
      post '/voucher', to: 'checkouts#voucher'
      post '/check_order_stripe', to: 'checkouts#check_order_stripe'
      post '/check_cart', to:'checkouts#check_cart'
      post '/refund_stripe', to:'orders#refund_stripe'
    end

    resource :webhook do
      post '/stripe', to: 'webhooks#stripe'
      post '/momo', to: 'webhooks#momo'
    end

    resource :user, only: [:edit, :update] do
      get '/profile/edit', to:'users#edit'
      patch '/profile/edit', to:'users#update'
      post '/profile', to:'users#show_profile'
      get '/password/change', to:'users#password'
      post '/password', to:'users#show_password'
      post 'addresses/change_address', to:'addresses#change_address'
      post 'addresses/show', to:'addresses#show_address'
      resource :order, only: [:show] do
        post '/show_order', to:'orders#show_order'
      end
      post 'order/detail', to:'orders#order_detail'
      get 'order/detail/:code', to:'orders#show_order_detail'
      resources :addresses do
        post '/:slug', to:'addresses#edit'
      end
    end
  # end
end
