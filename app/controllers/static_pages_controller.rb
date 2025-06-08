class StaticPagesController < ApplicationController
  skip_before_action :authenticate, only: [ :privacy, :terms ]
  def privacy
  end

  def terms
  end
end
