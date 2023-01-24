# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    resources :companies, except: [:index, :show]
  end

  namespace :v1 do
    resources :companies, only: [:index, :show]
  end
end
