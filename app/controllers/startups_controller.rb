class StartupsController < ApplicationController
  before_action :set_startup, only: [ :show, :like ]
  before_action :authenticate_user!, except: [ :index, :show, :like ]

  # Ensure the user is an admin for create and new actions
  before_action :authenticate_admin!, only: [ :new, :create ]

  # Ensure the user is an admin for like action
  before_action :authenticate_admin!, only: [ :like ]

  # Ensure the user is an admin for index action
  before_action :authenticate_admin!, only: [ :index ]
  def index
  end

  def new
    @startup = Startup.new
  end

  def create
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

  def like
    ip = request.remote_ip
    like = @startup.likes.find_by(ip_address: ip)
    if like
      like.destroy
      @startup.reload
      respond_to do |format|
        format.turbo_stream
        format.json { render json: { liked: false, count: @startup.likes.count } }
      end
    else
      @startup.likes.create(ip_address: ip)
      @startup.reload
      respond_to do |format|
        format.turbo_stream
        format.json { render json: { liked: true, count: @startup.likes.count } }
      end
    end
  end

  private
  def startup_params
    params.expect(startup: [ :name, :description, :tag_list ])
  end

  def set_startup
    @startup = Startup.find(params[:id])
  end
end
