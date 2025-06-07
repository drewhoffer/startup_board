class Startup < ApplicationRecord
  acts_as_taggable_on :tags
  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 50, maximum: 500 }
end
