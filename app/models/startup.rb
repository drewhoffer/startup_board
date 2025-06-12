class Startup < ApplicationRecord
  belongs_to :user

  acts_as_taggable_on :tags
  has_many :likes, dependent: :destroy
  has_many :roles, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 25, maximum: 500 }
  validates :roles, length: { minimum: 1, message: "must have at least one role" }

  validates :website_url, format: { with: URI::DEFAULT_PARSER.make_regexp("https"), allow_blank: true }
  validates :instagram_url, format: { with: /\Ahttps?:\/\/(www\.)?instagram\.com\//i, allow_blank: true, message: "must be an Instagram URL" }
  validates :twitter_url,   format: { with: /\Ahttps?:\/\/(www\.)?twitter\.com\//i, allow_blank: true, message: "must be a Twitter URL" }
  validates :linkedin_url,  format: { with: /\Ahttps?:\/\/(www\.)?linkedin\.com\//i, allow_blank: true, message: "must be a LinkedIn URL" }
  validates :github_url,    format: { with: /\Ahttps?:\/\/(www\.)?github\.com\//i, allow_blank: true, message: "must be a GitHub URL" }
  validates :discord_url,   format: { with: /\Ahttps?:\/\/(www\.)?discord\.(gg|com)\//i, allow_blank: true, message: "must be a Discord invite or server URL" }

  def self.ransackable_attributes(auth_object = nil)
    %w[name description created_at]
  end
end
