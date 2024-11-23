class UsersController < ApplicationController
  before_action :authenticate_user!  # Захистити редагування профілю лише для авторизованих користувачів

  # Перевірка доступності username
  def check_username
    username = params[:username]
    user = User.find_by(username: username)
    render json: { available: user.nil? }
  end

  # Редагування профілю користувача
  def edit
    @user = current_user  # Отримати поточного користувача
  end

  # Оновлення профілю користувача
  def update
    @user = current_user  # Отримати поточного користувача
    if @user.update(user_params)  # Оновити профіль
      redirect_to user_path(@user), notice: 'Профіль оновлено успішно!'
    else
      render :edit  # Якщо не вдалося оновити профіль, показати форму редагування
    end
  end

  private

  # Параметри для оновлення профілю
  def user_params
    params.require(:user).permit(:name, :username, :password, :password_confirmation)
  end
end
