# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources 'orderitems'
      resources 'menuitems'
      resources 'orders'
      resources 'restaurants'
    end
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
