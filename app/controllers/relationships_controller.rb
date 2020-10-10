class RelationshipsController < ApplicationController

  #before_action :set_user

  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  private

  #def set_user
  #  @user = User.find(params[:relationship][:followed_id])
  #end

end
