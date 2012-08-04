class NewsController < ApplicationController
  before_filter :find_stories
  before_filter :authenticate_user!
  
  def index
    if current_user.followships == 0
      redirect_to stories_path
    else
      @news = current_user.followed_stories
    end
  end
end
