class FollowsController < ApplicationController

  def create
    follow = Follow.new
    follow.user_id = current_user.id
    follow.follow = params[:follow]
    binding.pry
    follow.save
    redirect_to mypage_user_index_path
  end

  def destroy
    follow = Follow.find_by(follow: params[:id])
    follow.destroy
    redirect_to mypage_user_index_path
  end

end
