class ProductsController < ApplicationController
  before_action :authenticate_user! # Перевірка автентифікації
  before_action :set_product, only: %i[show edit update destroy]

  # Виведення всіх товарів на сторінку
  def index
    @products = Product.all
  end

  # Показати конкретний товар
  def show
  end

  # Форма для створення нового товару
  def new
    @product = Product.new
  end

  # Створення нового товару
  def create
    @product = Product.new(product_params)

    # Перевірка на дублювання назви
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

  # Оновлення інформації про товар
  def update
    # Перевірка на дублювання назви
    if Product.exists?(name: @product.name) && @product.name != params[:product][:name]
      flash.now[:error] = "Товар з такою назвою вже існує!"
      render :edit and return
    end

    if @product.update(product_params)
      redirect_to manage_products_path, notice: 'Товар успішно оновлений.'
    else
      render :edit
    end
  end

  # Видалення товару
  def destroy
    @product.destroy # Видаляємо продукт

    respond_to do |format|
      format.html { redirect_to request.referer, notice: 'Продукт успішно видалено.' }
      format.js   # Для AJAX запитів
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@product) } # Для Turbo
    end
  end

  # Метод для перегляду всіх товарів
  def manage
    @products = Product.all
  end

  private

  # Встановлюємо товар для show, edit, update, destroy
  def set_product
    @product = Product.find(params[:id])
  end

  # Дозволяємо лише ці параметри
  def product_params
    params.require(:product).permit(:name, :description, :price)
  end
end
