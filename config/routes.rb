Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
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

  # Admin
  namespace :admin do
    get '/', to: 'home#index'
    resources :attribute_product_titles
    resources :brands
    resources :categories
    delete 'users/:id/delete', to: 'users#destroy'
    resources :products
    resources :users
  end

  # Client
  root 'home#index'
  get 'category/:slug', to: 'home#change_category'
  get 'brand/:slug', to: 'home#change_brand'
  get 'product/load_more', to: 'home#load_more_product'
  resources :product_detail, only: [ :show ] do
    get '/:slug', to: 'product_detail#show'
  end
  resources :comments do
    post 'reply_comment', to: 'comments#reply_comment'
  end
  resource :cart, only: [:show] do
    get 'show_cart', to: 'cart#show'
    get 'checkout', to: 'cart#checkout'
    post 'order', to: 'cart#order'
    # post 'create_address', to: 'cart#create_address'
  end
  # resource :user do
  #   resource :addresses do
  #     get '/', to: 'addresses#index'
  #   end
  # end
end
