Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :merchants, only: [] do
    resources :dashboard, module: "merchant", only: [:index]
    resources :items, module: "merchant", only: [:index, :show]
    resources :invoices, module: "merchant", only: [:index]
  end

  namespace :admin do 
    get "/", to: "dashboard#index"
    resources :merchants, only: [:index, :show]
    resources :invoices, only: [:index]

  end
end
