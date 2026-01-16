# frozen_string_literal: true

Rails.application.routes.draw do
 require 'sidekiq/web'
 if Rails.env.development? || Rails.env.production?
    require "rack/session/cookie"
    mount Sidekiq::Web => '/sidekiq', :as => 'sidekiq'
  end
 mount Sidekiq::Web => '/sidekiq'
 # root to: "api/v1/registrations#new"
       devise_for :users, path: 'api/v1/devise', path_names: {
                     sign_in: 'login',
                     sign_out: 'logout',
                     registration: 'signup'
                   },
                   controllers: {
                     sessions: 'api/v1/sessions',
                     registrations: 'api/v1/registrations',
                     confirmations: 'api/v1/confirmations'
                   }

    devise_scope :user do
        root to: 'api/v1/registrations#new'
      end
  namespace :api do
    namespace :v1 do
      get 'menu_items/search', 'menu_items#search'
      put 'menu_items/:id/create_discount', to: 'menu_items#create_discount'
      resources 'restaurants' do
        resources 'menu_items', except: :show
      end

      # get 'orders/order_item/', 'order_items#show'
      resources 'orders', except: [:create, :destroy] do
        resources 'order_items', only: [:create, :show, :update]
        # post 'orders/order_items', 'order_items#create'
        # post 'payments/pay', to: 'payments#pay'
      end

      # Stripe routes
        # post "/checkout", to: "checkout#create"
        # get "/checkout/success", to: "checkout#success", as: :checkout_success
        # get "/checkout/cancel", to: "checkout#cancel",  as: :checkout_cancel

    end
  end
end
