class UserController < ApplicationController

  def mypage
    @user = current_user

    @follows = @user.follows
  end

  def edit
  end

  def show
    @user = User.find(params[:id])
    @q = Game.ransack(params[:q])
    @games = @q.result
  end

end
