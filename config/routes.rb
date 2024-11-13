Rails.application.routes.draw do
  root 'home#index'

  # Основні ресурси для товарів
  resources :products

  get 'manage_products', to: 'products#manage'

  resources :cart_items, only: [:create, :index]
  resources :orders
end
