class User < ApplicationRecord
  # Включення стандартних модулів Devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Асоціації
  has_many :orders
  has_many :cart_items

  # Валідації
  validates :name, length: { maximum: 10 }, allow_blank: true
  validates :email, presence: true, uniqueness: true
  validates :password, format: { with: /\A[a-zA-Z0-9]{6,}\z/, message: "Пароль має містити лише англійські літери та цифри і бути не менше 6 символів." }, allow_nil: true

  # Колбек для автоматичної конвертації email в нижній регістр
  before_save :downcase_email

  private

  # Метод для перетворення email в нижній регістр перед збереженням
  def downcase_email
    self.email = email.downcase
  end
end
