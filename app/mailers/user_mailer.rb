class UserMailer < ApplicationMailer
  def password_reset
    @user = params[:user]
    @signed_id = @user.generate_token_for(:password_reset)

    mail to: @user.email, subject: "Reset your password"
  end

  def email_verification
    @user = params[:user]
    @signed_id = @user.generate_token_for(:email_verification)

    mail to: @user.email, subject: "Verify your email"
  end

  def application_received
    @role = params[:role]
    @startup = @role.startup
    @applicant = params[:applicant]

    @confirmation_url = confirm_applicant_role_url(@startup, @role, applicant_id: @applicant.id)

    mail(
      to: @startup.user.email,
      subject: "🎉 New applicant for #{@role.title} at #{@startup.name}!"
    )
  end

  def application_accepted
    @role = params[:role]
    @startup = @role.startup

    mail(
      to: params[:applicant].email,
      subject: "🎉 You've been accepted for #{@role.title} at #{@startup.name}!"
    )
  end
end
