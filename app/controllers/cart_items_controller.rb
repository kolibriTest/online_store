class CartItemsController < ApplicationController
  before_action :authenticate_user!

  # Показуємо всі товари в кошику
  def index
    @cart_items = current_user.cart_items.includes(:product)
  end

  # Оновлення кількості товару в кошику
  def update
    @cart_item = current_user.cart_items.find(params[:id])

    # Перевірка: чи кількість товару не перевищує 10
    if params[:cart_item][:quantity].to_i <= 10 && params[:cart_item][:quantity].to_i >= 1
      @cart_item.update(quantity: params[:cart_item][:quantity])
      flash[:notice] = "Кількість товару оновлено!"
    else
      flash[:alert] = "Максимальна кількість товару — 10 упаковок!"
    end

    redirect_to cart_items_path
  end

  # Видалення товару з кошика
  def destroy
    @cart_item = current_user.cart_items.find(params[:id])
    @cart_item.destroy
    flash[:notice] = "Товар видалено з кошика!"
    redirect_to cart_items_path
  end

  # Додавання товару в кошик
  def add_to_cart
    @product = Product.find(params[:id])
    quantity = params[:quantity].to_i

    # Перевірка: чи кількість товару не перевищує 10
    quantity = 10 if quantity > 10 # Максимум 10 одиниць

    # Перевіряємо чи товар вже є в кошику
    cart_item = current_user.cart_items.find_by(product_id: @product.id)

    if cart_item
      cart_item.update(quantity: cart_item.quantity + quantity)
    else
      current_user.cart_items.create(product: @product, quantity: quantity)
    end

    flash[:notice] = "Товар додано до кошика!"
    redirect_to cart_items_path
  end
end
