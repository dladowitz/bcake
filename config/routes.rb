Rails.application.routes.draw do
  # root
  root to: "landing_pages#landing"

  # matches only when :id is a number. allows all others to pass through.
  get "/:id", to: "locations#show", constraints: { id: /\d+/}

  # custom routes
  get    :landing,     to: "landing_pages#landing",      as: :landing
  get    :contact,     to: "landing_pages#contact",      as: :contact
  get    :signin,      to: "sessions#new",               as: :signin
  get    :signup,      to: "users#new",                  as: :signup

  # maybe make into a named resource
  get    :request_password,        to: "password_resets#request_password", as: :request_password
  get    "/reset_password/:token", to: "password_resets#reset_password",   as: :reset_password
  patch  "/reset_password/:token", to: "password_resets#update",           as: :password_reset

  # maybe roll these into their own controller instead of using locations
  get "/user/locations",    to: "locations#user_locations", as: :user_locations
  get "/user/locations/:id", to: 'locations#user_location', as: :user_location

  # resource routes
  resources :users
  resources :locations, only: [:index, :show, :new, :create] do
    member do
      post :signup
    end

    resources :deals, only: [:new, :create, :edit, :update]
  end

  # resources :customers, only: [:create]
  resources :sessions, only: [:new, :create, :destroy]
  resources :password_resets, only: [:create]





  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
