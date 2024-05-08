Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "questions#index"

  resources :users
  resources :ranks
  resources :roles
  resources :categories
  resources :questions
  resources :answers


  get "sessions/new" => "sessions#new", as: :new_session
  post "sessions" => "sessions#create", as: :sessions
  delete "session" => "sessions#destroy", as: :session

  patch "helpful" => "answers#set_helpful", as: :helpful

  get "search/new" => "search#new", as: :new_search
  post "search/show" => "search#show", as: :search

  get "imprint" => "legal#imprint", as: :imprint
  get "contact" => "legal#contact", as: :contact
  get "privacy" => "legal#privacy", as: :privacy
  
end
