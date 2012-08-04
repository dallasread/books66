class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def find_stories
    if user_signed_in?
      @stories ||= current_user.stories
    end
  end
  
  helper_method :find_stories
end
