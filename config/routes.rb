Rails.application.routes.draw do
  root 'events#index'

  devise_for :users

  resources :events
  resources :users
  resources :attendances
  post "events/:id/attendances", to: "attendances#new", as: "inscription"
  resources :charges, only:[:new, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
