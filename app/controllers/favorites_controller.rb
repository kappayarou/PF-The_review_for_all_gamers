class FavoritesController < ApplicationController
  def create
    favorite = Favorite.new
    favorite.user_id = current_user.id
    favorite.review_id = params[:review_id]
    favorite.save
    redirect_to reviews_path(review_type: params[:review_type], game_id: params[:game_id])
  end

  def destroy
    favorite = Favorite.find_by(user_id: params[:user_id])
    favorite.destroy
    redirect_to reviews_path(review_type: params[:review_type], game_id: params[:game_id])
  end
end
