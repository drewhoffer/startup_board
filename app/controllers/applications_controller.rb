class ApplicationsController < ApplicationController
  def create
    role = Role.find(params[:role_id])
    application = role.applications.build(user: Current.user)

    if application.save
      redirect_to startup_path(role.startup), notice: "You applied!"
    else
      redirect_to startup_path(role.startup), alert: "You already applied or something went wrong."
    end
  end
end
