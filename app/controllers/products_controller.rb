class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy, :add_to_cart]
  before_action :check_admin, only: [:manage, :new, :create, :edit, :update, :destroy]
  before_action :set_product, only: %i[show edit update destroy add_to_cart]

  # Головна сторінка
  def home
    @products = Product.all
  end

  # Сторінка каталогу товарів
  def index
    query = params[:query]
    @products = query.present? ? Product.where('name LIKE ?', "%#{query}%") : Product.all
  end

  # Сторінка окремого продукту
  def show; end

  # Створення нового продукту
  def new
    @product = Product.new
  end

  # Збереження нового продукту
  def create
    @product = Product.new(product_params)
    if Product.exists?(name: @product.name)
      flash.now[:error] = "Товар з такою назвою вже існує!"
      render :new and return
    end
    if @product.save
      redirect_to manage_products_path, notice: 'Товар успішно додано.'
    else
      render :new
    end
  end

  # Редагування продукту
  def edit; end

  # Оновлення продукту
  def update
    if Product.exists?(name: params[:product][:name]) && @product.name != params[:product][:name]
      flash.now[:error] = "Товар з такою назвою вже існує!"
      render :edit and return
    end
    if @product.update(product_params)
      redirect_to manage_products_path, notice: 'Товар успішно оновлено.'
    else
      render :edit
    end
  end

  # Видалення продукту
  def destroy
    # Видаляємо пов'язані записи перед видаленням продукту
    if defined?(Cart)
      Cart.where(product_id: @product.id).destroy_all
    end

    if @product.destroy
      redirect_to manage_products_path, notice: 'Продукт успішно видалено.'
    else
      redirect_to manage_products_path, alert: 'Не вдалося видалити продукт.'
    end
  end

  # Додавання товару до кошика
  def add_to_cart
    quantity = params[:quantity].to_i
    @cart_item = current_user.cart_items.find_or_initialize_by(product: @product)
    @cart_item.quantity ||= 0
    @cart_item.quantity += quantity
    @cart_item.quantity = 10 if @cart_item.quantity > 10

    if @cart_item.save
      redirect_to cart_items_path, notice: "Товар додано в кошик."
    else
      redirect_to product_path(@product), alert: "Не вдалося додати товар в кошик."
    end
  end

  # Сторінка управління товарами
  def manage
    @products = Product.all
  end

  private

  def check_admin
    unless current_user&.email == 'administrator@gmail.com'
      redirect_to root_path, alert: 'Тільки адміністратори можуть управляти товарами.'
    end
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :image)
  end
end
