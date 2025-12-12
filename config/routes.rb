# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources 'orders' do
        resources 'order_items'
      end

      resources 'restaurants' do
        resources 'menu_items'
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
