class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # Ensure a user can like a post only once
  validates :user_id, uniqueness: { scope: :post_id }
end
