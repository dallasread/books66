class UsersController < ApplicationController
  before_filter :find_stories
  
  def index
    if current_user.follows.empty?
      @users = User.where("id != ?", current_user).order(:name)
    else
      @users = User.where("id != ? and id not in (?)", current_user, current_user.follows).order(:name)
    end
  end

  def show
    @user = User.find(params[:id])
    
    if user_signed_in?
      @followship = Followship.find_by_user_id_and_follow_id(current_user, @user)
    end
  end
end
