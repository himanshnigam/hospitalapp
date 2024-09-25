class Doctor < ApplicationRecord
    has_many :appointments
    has_many :patients, through: :appointments
    has_many :notifications, as: :recipient, dependent: :destroy, class_name: "Noticed::Notification"

    has_secure_password

    enum availability: { available: 0, booked: 1, absent: 2 }

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
end
