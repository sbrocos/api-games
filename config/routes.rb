# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :v1 do
    namespace :admin do
      resources :companies, except: [:index, :show]
    end
    resources :companies, only: [:index, :show]
    resources :publishers, controller: :companies, type: 'Publisher', only: [:index, :show]
    resources :developers, controller: :companies, type: 'Developer', only: [:index, :show]
  end
end
