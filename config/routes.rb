# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, path: 'devise', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'

  },
                     controllers: {
                       sessions: 'api/v1/sessions',
                       registrations: 'api/v1/registrations'
                     }

  # devise_for :users
  # Authentication
  # post "/signup", "authentication#create"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
