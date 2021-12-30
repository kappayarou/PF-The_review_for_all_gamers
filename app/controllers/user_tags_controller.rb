class UserTagsController < ApplicationController

  def create
    @user_tag = UserTag.new(user_tag_params)
    binding.pry
    @user_tag.save
    redirect_to games_path
  end

  private
  def user_tag_params
    params.require(:user_tag).permit(:tag)
  end

end
