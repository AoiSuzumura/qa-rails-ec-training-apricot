class User < ApplicationRecord
  belongs_to :user_classification
  has_many :orders, dependent: :destroy
  has_many :products, dependent: :destroy
  has_one :cart, dependent: :destroy

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  has_secure_password
  validates :password, presence: true, length: { minimum: 6, maximum: 15 },
                       format: { with: VALID_PASSWORD_REGEX }, allow_nil: true
  validates :last_name, presence: true, length: { maximum: 10 }
  validates :first_name, presence: true, length: { maximum: 10 }
  validates :zipcode, presence: true, length: { is: 7 }, format: { with: /\A[0-9]+\z/ }
  validates :prefecture, presence: true, length: { maximum: 5 }
  validates :municipality, presence: true, length: { maximum: 10 }
  validates :address, presence: true, length: { maximum: 15 }
  validates :apartments, presence: true, length: { maximum: 20 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  validates :phone_number, presence: true, length: { maximum: 15 }, format: { with: /\A[0-9]+\z/ }

  def self.guest
    find_or_create_by!(email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64(6)
      user.last_name = "Guest"
      user.first_name = "User"
      user.zipcode = "1234567"
      user.prefecture = "Tokyo"
      user.municipality = "Minato-ku"
      user.address = "123 Street"
      user.apartments = "Apartment 1"
      user.phone_number = "1234567890"
      user.user_classification_id = 1
      user.company_name = "Guest Company"
      user.delete_flag = false
    end
  end
end
