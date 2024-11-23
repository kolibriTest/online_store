class User < ApplicationRecord
  # Включення стандартних модулів Devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Асоціації
  has_many :orders

  # Валідації
  validates :name, length: { maximum: 10 }, allow_blank: true


  has_many :cart_items
  # Валідація для username
  validates :username, presence: true, uniqueness: true,
                       format: { with: /\A[a-z0-9_-]{6,}\z/, message: "Має бути від 6 символів і містити лише малі літери, цифри, тире або нижні підкреслення." }

  # Валідація для email
  validates :email, presence: true, uniqueness: true

  # Валідація для паролю
  validates :password, format: { with: /\A[a-zA-Z0-9]{6,}\z/, message: "Пароль має містити лише англійські літери та цифри і бути не менше 6 символів." }, allow_nil: true

  # Callback для автоматичної конвертації username в нижній регістр
  before_save :downcase_username

  private

  # Метод для перетворення username в нижній регістр перед збереженням
  def downcase_username
    self.username = username.downcase
  end
end
