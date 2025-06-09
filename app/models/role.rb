class Role < ApplicationRecord
  belongs_to :startup
  belongs_to :user, optional: true
  has_many :applications, dependent: :destroy
  has_many :applicants, through: :applications, source: :user

  enum :status, { open: 0, taken: 1 }
end
