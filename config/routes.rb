Rails.application.routes.draw do
  root 'home#index'  # Головна сторінка
  resources :products  # Ресурси для товарів
  resources :cart_items  # Ресурси для кошика
  resources :orders  # Ресурси для замовлень
end
