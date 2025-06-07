class HomeController < ApplicationController
  def index
    @startups = Startup.all
  end
end
