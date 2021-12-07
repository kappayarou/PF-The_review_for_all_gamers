class ReviewsController < ApplicationController

  def new
    @game = Game.find(params[:game_id])
    @review = Review.new
    @review_type = {"ポジティブレビュー": 0, "ネガティブレビュー": 1}
  end

  def create
    review = Review.new(review_params)
    review.user_id = current_user.id
    review.save
    redirect_to games_path
  end

  private
  def review_params
    params.require(:review).permit(:review_type, :game_id, :review)
  end

end
