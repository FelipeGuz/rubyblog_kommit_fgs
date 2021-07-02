# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'articles#index'

  # resources deal with all CRUD operations
  resources :articles do
    resources :comments
  end
end
