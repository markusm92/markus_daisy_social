class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :posts, dependent: :destroy

  # Associations for social features
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
