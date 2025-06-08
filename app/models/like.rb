class Like < ApplicationRecord
  belongs_to :startup
  validates :ip_address, presence: true
  validates :startup_id, uniqueness: { scope: :ip_address }
end
