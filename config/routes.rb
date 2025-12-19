# frozen_string_literal: true

Rails.application.routes.draw do
 require 'sidekiq/web'
 mount Sidekiq::Web => '/sidekiq'
  namespace :api do
    namespace :v1 do
      resources 'restaurants' do
        resources 'menu_items', except: :show
      end

      resources 'orders', except: [:create, :destroy] do
        resources 'order_items', only: [:create, :show]
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
  # match '*unmatched', to: 'application#route_not_found', via: :all
end
