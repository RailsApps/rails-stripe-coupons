Rails.application.routes.draw do
  resources :coupons
  get 'products/:id', to: 'products#show', :as => :products
  devise_for :users, :controllers => { :registrations => 'registrations' }
  resources :users
  root :to => 'visitors#index'
end
