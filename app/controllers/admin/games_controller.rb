class Admin::GamesController < ApplicationController
  def index
    @games = Game.all
    @admin_tags = AdminTag.all
    @user_tags = UserTag.all

    @tag = AdminTag.new
  end

end
