# frozen_string_literal: true

Rails.application.routes.draw do
  root 'articles#index'

  devise_for :users
  resources :follow

  # resources deal with all CRUD operations
  resources :articles do
    resources :comments
  end
end
