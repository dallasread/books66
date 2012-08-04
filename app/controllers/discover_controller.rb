class DiscoverController < ApplicationController
  before_filter :find_stories
  
  def index
    if user_signed_in?
      if current_user.follows.empty?
        @community = Story.where("user_id != ?", current_user)
      else
        @community = Story.where("user_id != ? and user_id not in (?)", current_user, current_user.follows)
      end
    else
      @community = Story.limit(20)
    end
  end
end
