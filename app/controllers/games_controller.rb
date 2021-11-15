class GamesController < ApplicationController

  def index
    @games = Game.all
    @admin_tags = AdminTag.all
    @user_tags = UserTag.all
  end

end
