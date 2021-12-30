class Admin::UsersController < ApplicationController

  before_action :admin_judgement

  def admin_judgement
    if !admin_signed_in?
      redirect_to root_path
    end
  end

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
    user = User.find(params[:id])
    user.update(admin_user_params)
    redirect_to admin_user_path
  end

  def reviews_index
    @user = User.find(params[:user_id])
    @reviews = @user.reviews
  end

  def review_destroy
    review = Review.find(params[:review_id])
    review.destroy
    redirect_to reviews_index_admin_users_path(user_id: review.user.id)
  end

  private
  def admin_user_params
    params.require(:user).permit(:email, :nickname, :is_active, :report)
  end

end
