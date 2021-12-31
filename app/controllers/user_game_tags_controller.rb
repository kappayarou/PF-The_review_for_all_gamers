class UserGameTagsController < ApplicationController

  def new
    @game = Game.find(params[:game_id])
    @user_game_tag = UserGameTag.new
  end

  def update
    tags = params[:game][:user_game_tag_ids]
    if tags
      tags.each do |tag|
        if UserGameTag.where(user_tag_id: UserTag.find(tag).id) == []
          user_game_tag = UserGameTag.new(user_game_tag_params)
          user_game_tag.user_tag_id = UserTag.find(tag).id
          user_game_tag.save
        end
      end
    end
    redirect_to game_path(params[:game][:game_id])
  end

  private
  def user_game_tag_params
    params.require(:game).permit(:game_id)
  end

end
