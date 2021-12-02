class FollowsController < ApplicationController

  def create
    follow = Follow.new
    follow.user_id = current_user.id
    follow.follow = params[:follow].to_i
    if follow.follow != follow.user_id
      follow.save
    end
    binding.pry
    redirect_to user_path(follow.follow)
  end

  def destroy
    follow = Follow.find_by(follow: params[:id])
    follow.destroy
    redirect_to user_path(follow.follow)
  end

end
