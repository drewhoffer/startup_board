class Startup < ApplicationRecord
  acts_as_taggable_on :tags

  has_many :likes, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 25, maximum: 500 }
end
