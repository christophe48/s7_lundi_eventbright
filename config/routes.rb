Rails.application.routes.draw do
  root 'events#index'
  get 'static_pages/secret'
  devise_for :users

  resources :events
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
