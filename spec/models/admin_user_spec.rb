require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  # Додати тест для AdminUser, якщо є специфікації або можна видалити, якщо не потрібен
  it 'validates presence of email' do
    admin_user = AdminUser.new(email: nil)
    expect(admin_user).not_to be_valid
  end
end
