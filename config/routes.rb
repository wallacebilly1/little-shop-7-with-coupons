Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :merchants, only: [] do
    resources :dashboard, module: "merchant", only: [:index]
    resources :items, module: "merchant", except: [:destroy]
    resources :invoices, module: "merchant", only: [:index, :show]
  end

  namespace :admin do 
    get "/", to: "dashboard#index"
    resources :merchants, only: [:index, :show, :edit, :update, :new, :create]
    resources :invoices, only: [:index, :show, :edit, :update]

  end
end
