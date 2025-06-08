class Like < ApplicationRecord
  belongs_to :startup
  belongs_to :user

  validates :user_id, presence: true
  validates :startup_id, uniqueness: { scope: :user_id }
end
