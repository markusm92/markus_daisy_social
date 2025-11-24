class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images

  # Add associations for social features
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
end
