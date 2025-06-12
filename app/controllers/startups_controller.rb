class StartupsController < ApplicationController
  before_action :set_startup, only: [ :show, :like, :edit, :update, :destroy ]
  skip_before_action :authenticate, only: [ :index, :show, :search ]

  def index
    @q = Startup.ransack(params[:q])
    @startups = @q.result(distinct: true).order(created_at: :desc)
  end

  def search
    @q = Startup.ransack(params[:q])
    @startups = @q.result(distinct: true)
  end

  def new
    @startup = Startup.new
  end

  def edit
    unless @startup.user == Current.user
      redirect_to root_path, alert: "You can only edit your own startups."
    end
  end


  def update
    unless @startup.user == Current.user
      redirect_to root_path, alert: "You can only update your own startups."
      return
    end

    if @startup.update(startup_params.except(:role_names))
      submitted_titles = (startup_params[:role_names] || "").split(",").map(&:strip).uniq
      @startup.roles.where.not(title: submitted_titles).destroy_all

      existing_titles = @startup.roles.pluck(:title)
      (submitted_titles - existing_titles).each do |title|
        @startup.roles.create(title: title, status: :open)
      end
      redirect_to @startup, notice: "Startup was successfully updated."
    else
      flash.now[:alert] = "There was an error updating the startup."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    unless @startup.user == Current.user
      redirect_to root_path, alert: "You can only delete your own startups."
      return
    end

    @startup.destroy
    redirect_to startups_path, notice: "Startup was successfully deleted."
  end

  def create
    @startup = Startup.new(startup_params.except(:role_names))
    @startup.user = Current.user
      if startup_params[:role_names].present?
        role_titles = startup_params[:role_names].split(",")
        role_titles.each do |title|
          @startup.roles.build(title: title.strip, status: :open) # or your default status
        end
      end
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
    params.require(:startup).permit(:name,
                                    :description,
                                    :tag_list,
                                    :role_names,
                                    :website_url,
                                    :instagram_url,
                                    :twitter_url,
                                    :linkedin_url,
                                    :github_url,
                                    :discord_url)
  end

  def set_startup
    @startup = Startup.find(params[:id])
  end
end
