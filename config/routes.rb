Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users,
  path: '',
  path_names: { sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'register' },
  controllers: { omniauth_callbacks: "omniauth_callbacks" }
  
  # scope '(:locale)', locale: /en|ja|vi/ do
    root 'home#index'

    # User
    devise_scope :user do 
      get 'register', to: 'devise/registrations#new'
      get 'login', to: 'devise/sessions#new'
      get 'logout', to: 'devise/sessions#destroy'
    end
  # end
end
