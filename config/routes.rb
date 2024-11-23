Rails.application.routes.draw do
  # Маршрути для Devise
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  # Обробка видалення облікового запису через Devise
  delete 'users', to: 'users/registrations#destroy'

  # Перевірка імені користувача
  get '/check_username', to: 'users#check_username'

  # Ресурси для товарів
  resources :products, only: [:index, :show, :destroy, :new, :create, :edit, :update] do
    collection do
      get 'manage' # Маршрут для сторінки управління товарами
    end
  end

  # Ресурси для кошика
  resources :cart_items, only: [:create, :index]

  # Ресурси для замовлень
  resources :orders

  # Головна сторінка
  root to: 'home#index'
end
