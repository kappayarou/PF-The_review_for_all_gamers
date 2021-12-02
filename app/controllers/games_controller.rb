class GamesController < ApplicationController

  def index
    @games = Game.all
    @admin_tags = AdminTag.all
    @user_tags = UserTag.all

    @tag = UserTag.new


    @sort_select = {"評価順" => 0, "新着順" => 1}

    sort_key = 1

    if params[:choiced]
      sort_key = params[:choiced].to_i
    end

    @sort_prompt = 0

    @q = Game.ransack(params[:q])

    if sort_key == 0
      @games = @q.result(distinct: true).order(rating: :desc).limit(10)
      @sort_prompt = 0
    elsif sort_key == 1
      @games = @q.result(distinct: true).order(created_at: :desc).limit(10)
      @sort_prompt = 1
    end
  end

  def show
    @game = Game.find(params[:id])
    @admin_game_tags = @game.admin_game_tags
    @user_game_tags = @game.user_game_tags
  end

end
