class HomeController < ApplicationController
  def index
    @startups = Startup.all
    @liked_startup_ids = Like.where(ip_address: request.remote_ip).pluck(:startup_id)
  end
end
