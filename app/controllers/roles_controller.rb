class RolesController < ApplicationController
  def confirm_applicant
    role = Role.find(params[:id])
    applicant = User.find(params[:applicant_id])

    if role.update(user: applicant)
      # Send confirmation to applicant
      UserMailer.with(role: role, applicant: applicant).application_accepted.deliver_later

      redirect_to startup_path(role.startup), notice: "#{applicant.email} has been accepted!"
    else
      redirect_to startup_path(role.startup), alert: "Could not assign applicant."
    end
  end
end
