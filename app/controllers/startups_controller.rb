class StartupsController < ApplicationController
  def index
  end

  def new
    @startup = Startup.new
  end

  def create
    Rails.logger.info "Creating startup with params: #{startup_params.inspect}"
    @startup = Startup.new(startup_params)
    if @startup.save
      redirect_to root_path, notice: "Startup was successfully created."
    else
      flash.now[:alert] = "There was an error creating the startup."
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  private
  def startup_params
    params.expect(startup: [ :name, :description, :tag_list ])
  end
end
