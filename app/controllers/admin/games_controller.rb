class Admin::GamesController < ApplicationController
  def index
    @games = Game.all
    @admin_tags = AdminTag.all
    @user_tags = UserTag.all

    @tag = AdminTag.new
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

    params_tags = params[:admin_tag_id]
    binding.pry
    params_tags.each do |params_tag|
      admin_game_tag = AdminGameTag.new
      admin_game_tag.game_id = game.id
      admin_game_tag.admin_tag_id = params_tag
      admin_game_tag.save
    end


    redirect_to admin_game_path(game.id)
  end

  private
  def admin_game_params
    params.require(:game).permit(:title, :description, :image, :admin_rating)
  end

end
