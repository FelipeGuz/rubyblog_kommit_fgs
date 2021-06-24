Rails.application.routes.draw do
  root "articles#index"

  # resources deal with all CRUD operations
  resources :articles do 
    resources :comments
  end
end
