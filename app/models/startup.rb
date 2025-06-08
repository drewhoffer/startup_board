class Startup < ApplicationRecord
  acts_as_taggable_on :tags

  has_many :likes, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 25, maximum: 500 }
  validates :url, format: { with: URI::DEFAULT_PARSER.make_regexp("https"), allow_blank: true }

  def self.ransackable_attributes(auth_object = nil)
    %w[name description created_at]
  end
end
