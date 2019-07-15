# frozen_string_literal: true

Rails.application.routes.draw do
  resources :invitations, controller: 'rails_jwt_auth/invitations', only: [:create, :update]
  resources :passwords, controller: 'rails_jwt_auth/passwords', only: [:create, :update]
  resources :confirmations, controller: 'rails_jwt_auth/confirmations', only: [:create, :update]
  resources :registration, controller: 'rails_jwt_auth/registrations', only: [:create, :update, :destroy]
  resources :session, controller: 'rails_jwt_auth/sessions', only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
