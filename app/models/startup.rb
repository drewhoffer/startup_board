class Startup < ApplicationRecord
  belongs_to :user

  acts_as_taggable_on :tags
  has_many :likes, dependent: :destroy
  has_many :roles, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 25, maximum: 500 }
  validates :url, format: { with: URI::DEFAULT_PARSER.make_regexp("https"), allow_blank: true }
  validates :roles, length: { minimum: 1, message: "must have at least one role" }

  def self.ransackable_attributes(auth_object = nil)
    %w[name description created_at]
  end
end
