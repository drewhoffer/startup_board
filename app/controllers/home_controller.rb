class HomeController < ApplicationController
  skip_before_action :authenticate
  before_action :set_liked_startup_ids
  def index
    @q = Startup.ransack(params[:q])
    @startups = @q.result(distinct: true)
  end

  def search
    @q = Startup.ransack(params[:q])
    @startups = @q.result(distinct: true)
  end

  private

  def set_liked_startup_ids
    if Current.user
      @liked_startup_ids = Like.where(user: Current.user.id).pluck(:startup_id)
    end
  end
end
