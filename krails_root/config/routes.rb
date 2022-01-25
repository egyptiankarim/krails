Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "static#index"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get 'index', to: "static#index", as: :home
  get 'about', to: "static#about", as: :about
end
