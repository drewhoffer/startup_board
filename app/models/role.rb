class Role < ApplicationRecord
  belongs_to :startup

  enum :status, { open: 0, taken: 1 }
end
