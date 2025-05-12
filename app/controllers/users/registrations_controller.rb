class Users::RegistrationsController < Devise::RegistrationsController
  # Перевизначення методу update
  def update
    # Якщо передано пароль, перевіряємо його
    if params[:user][:password].present? || params[:user][:password_confirmation].present?
      if current_user.update_with_password(user_params_with_password)
        bypass_sign_in(current_user)
        redirect_to edit_user_registration_path, notice: "Профіль успішно оновлено."
      else
        render :edit
      end
    else
      # Якщо пароль не змінюється, оновлюємо інші поля
      if current_user.update(user_params)
        redirect_to edit_user_registration_path, notice: "Профіль успішно оновлено."
      else
        render :edit
      end
    end
  end

  private

  # Дозволяємо оновлювати всі параметри без пароля
  def user_params
    params.require(:user).permit(:name, :username, :email)
  end

  # Дозволяємо оновлювати пароль з обов'язковою перевіркою current_password
  def user_params_with_password
    params.require(:user).permit(:name, :username, :email, :password, :password_confirmation, :current_password)
  end
end
