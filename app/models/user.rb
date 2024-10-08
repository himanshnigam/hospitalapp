class User < ApplicationRecord
    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :notifications, as: :recipient, dependent: :destroy, class_name: "Noticed::Notification"

    has_many :follows, foreign_key: :follower_id, dependent: :destroy
    has_many :followed_users, through: :follows, source: :followed

    require "securerandom"

    has_secure_password

    validates :email, :username, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 6 }
    validates :name, presence: true
end
