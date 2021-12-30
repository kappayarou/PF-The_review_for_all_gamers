class Admin::GamesController < ApplicationController

  before_action :admin_judgement

  def admin_judgement
    if !admin_signed_in?
      redirect_to root_path
    end
  end

  def index
    @games = Game.all
    @admin_tags = AdminTag.all
    @user_tags = UserTag.all

    @tag = AdminTag.new

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

  def new
    @game = Game.new
    @admin_tags = AdminTag.all
    @admin_tags_list = {}
    @admin_tags.each do |admin_tag|
      @admin_tags_list.store(admin_tag.tag, admin_tag.id)
    end
  end

  def create
    game = Game.new(admin_game_params)
    game.admin_id = current_admin.id
    game.save

    params_tags = params[:game][:admin_game_tag_ids]
    params_tags.each do |params_tag|
      admin_game_tag = AdminGameTag.new
      admin_game_tag.game_id = game.id
      admin_game_tag.admin_tag_id = params_tag
      admin_game_tag.save
    end


    redirect_to admin_game_path(game.id)
  end

  def show
    @game = Game.find(params[:id])
    @admin_game_tags = @game.admin_game_tags
    @user_game_tags = @game.user_game_tags
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    game = Game.find(params[:id])
    base_rating = game.admin_rating
    game.update(admin_game_params)
    if game.admin_rating != base_rating
      game.admin_id = current_admin.id
    end
    redirect_to admin_game_path(game.id)
  end

  def destroy
    game = Game.find(params[:id])
    game.destroy
    redirect_to admin_games_path
  end

  private
  def admin_game_params
    params.require(:game).permit(:title, :description, :image, :admin_rating)
  end

end
