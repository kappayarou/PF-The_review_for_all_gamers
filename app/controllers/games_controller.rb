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

    ratings = @game.ratings
    ratings_list = []
    ratings.each do |rating|
      ratings_list.append(rating.rating)
    end

    if ratings_list.length != 0
      @rating_score = ratings_list.sum / ratings_list.length
    else
      @rating_score = 0
    end

    @rating = Rating.new

    binding.pry

  end

  def rating_create
    rating = Rating.new(rating_create_params)
    if rating.game.ratings.where(user_id: current_user.id) != []
      redirect_to game_path(rating.game_id)
      binding.pry
    else
      rating.save
      redirect_to game_path(rating.game_id)
    end
  end

  private
  def rating_create_params
    params.require(:rating).permit(:rating, :game_id, :user_id)
  end

end
