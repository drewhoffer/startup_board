class HomeController < ApplicationController
  def index
    @q = Startup.ransack(params[:q])
    @startups = @q.result(distinct: true)
    @liked_startup_ids = Like.where(ip_address: request.remote_ip).pluck(:startup_id)
  end
end
