class Application < ApplicationRecord
  belongs_to :user
  belongs_to :role

  validates :user_id, uniqueness: { scope: :role_id, message: "has already applied for this role" }
  validate :user_is_not_startup_owner

  private

  def user_is_not_startup_owner
    Rails.logger.debug "Validating user_id: #{user_id}, role: #{role.inspect}, startup: #{role&.startup.inspect}"
    if role && role.startup && user_id == role.startup.user_id
      errors.add(:user_id, "cannot apply to your own startup's role")
    end
  end
end
