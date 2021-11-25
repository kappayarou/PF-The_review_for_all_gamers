class Admin::UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = Game.find(params[:id])
    user.update(admin_user_params)
    redirect_to admin_user_path
  end

  def reviews_index
  end

  def review_destroy
  end

  private
  def admin_user_params
    params.require(:user).permit(:email, :nickname, :is_active, :report)
  end

end
