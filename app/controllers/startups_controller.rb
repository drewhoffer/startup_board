class StartupsController < ApplicationController
  before_action :set_startup, only: [ :show, :like ]
  skip_before_action :authenticate, only: [ :index, :show ]

  def index
    @q = Startup.ransack(params[:q])
    @startups = @q.result(distinct: true)
  end

  def search
    @q = Startup.ransack(params[:q])
    @startups = @q.result(distinct: true)
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
    like = @startup.likes.find_by(user_id: Current.user.id)
    if like
      like.destroy
      @startup.reload
      respond_to do |format|
        format.turbo_stream
        format.json { render json: { liked: false, count: @startup.likes.count } }
      end
    else
      @startup.likes.create(user_id: Current.user.id)
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
