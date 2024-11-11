class HomeController < ApplicationController
  def index
    @products = Product.all.limit(5)  # Обмежуємо кількість товарів для відображення
  end
end
