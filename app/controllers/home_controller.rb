class HomeController < ApplicationController
  def index
    # Пошук товарів за запитом
    if params[:query].present?
      @products = Product.where('name LIKE ?', "%#{params[:query]}%")
    else
      @products = []  # Якщо немає запиту, не показуємо продукти
    end
  end
end
