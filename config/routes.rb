# frozen_string_literal: true

Rails.application.routes.draw do
 require 'sidekiq/web'
 mount Sidekiq::Web => '/sidekiq'
  namespace :api do
    namespace :v1 do
      get 'menu_items/search', 'menu_items#search'
      resources 'restaurants' do
        resources 'menu_items', except: :show
      end

      # get 'orders/order_item/', 'order_items#show'
      resources 'orders', except: [:create, :destroy] do
        resources 'order_items', only: [:create, :show]
        # post 'orders/order_items', 'order_items#create'
      end

      devise_for :users, path: 'devise', path_names: {
        sign_in: 'login',
        sign_out: 'logout',
        registration: 'signup'
      },
      controllers: {
       sessions: 'api/v1/sessions',
       registrations: 'api/v1/registrations'
     }

    end
  end
end
