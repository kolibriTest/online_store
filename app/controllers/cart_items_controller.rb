class CartItemsController < ApplicationController
  before_action :set_product, only: [:create]

  def create
    # Якщо кошик уже існує для поточного користувача, знаходимо або створюємо новий запис
    @cart_item = current_user.cart_items.find_or_initialize_by(product: @product)

    # Оновлюємо кількість товару в кошику, додаючи нову кількість до поточної
    @cart_item.quantity += params[:cart_item][:quantity].to_i

    # Зберігаємо зміни
    if @cart_item.save
      redirect_to cart_items_path, notice: 'Товар додано до кошика.'
    else
      redirect_to products_path, alert: 'Не вдалося додати товар до кошика.'
    end
  end

  def index
    # Виводимо всі товари в кошику для поточного користувача
    @cart_items = current_user.cart_items
  end

  private

  def set_product
    # Знаходимо продукт по ID, який передається без обгортки
    @product = Product.find(params[:product_id])
  end
end
