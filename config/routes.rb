# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :v1 do
    namespace :admin do
      resources :companies, except: %i[index show]
      resources :games, except: %i[index show]
    end
    resources :companies, only: %i[index show]
    resources :publishers, controller: :companies, type: 'Publisher', only: %i[index show]
    resources :developers, controller: :companies, type: 'Developer', only: %i[index show]
    resources :games, only: %i[index show]
  end
end
