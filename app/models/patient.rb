class Patient < ApplicationRecord
  has_many :appointments
  has_many :doctors, through: :appointments

  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
