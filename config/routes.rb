# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :v1 do
    namespace :admin do
      resources :companies, except: [:index, :show]
    end
    resources :companies, only: [:index, :show]
  end
end
