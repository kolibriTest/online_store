Rails.application.routes.draw do
  # Маршрути для Devise
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  delete 'users', to: 'users/registrations#destroy'

  # Перевірка імені користувача
  get '/check_username', to: 'users#check_username'

  # Ресурси для товарів
  resources :products, only: [:index, :show, :destroy, :new, :create, :edit, :update] do
    collection do
      get 'manage'
      get 'search'  # Шлях для пошуку
    end
    member do
      post 'add_to_cart'  # Додавання товару в кошик
    end
  end

  # Ресурси для кошика
  resources :cart_items, only: [:index, :update, :destroy]

  # Ресурси для оплати
  resources :orders, only: [:new, :create, :show]

  # Головна сторінка
  root to: 'home#index'  # Маршрут для головної сторінки
end
