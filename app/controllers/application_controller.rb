class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :set_current_request_details
  before_action :authenticate

  private
    def authenticate
      if session_record = Session.find_by_id(cookies.signed[:session_token])
        Current.session = session_record
      else
        respond_to do |format|
          format.html { redirect_to sign_in_path, alert: "You gotta sign in to do that." }
            format.turbo_stream do
              flash[:alert] = "You gotta sign in to do that."
              render turbo_stream: turbo_stream.action(:redirect, sign_in_path)
            end
        end
      end
    end

    def set_current_request_details
      Current.user_agent = request.user_agent
      Current.ip_address = request.ip
    end
end
