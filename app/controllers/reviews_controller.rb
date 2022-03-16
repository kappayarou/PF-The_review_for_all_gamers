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
    redirect_to game_path(review.game_id)
  end

  def index
    if params[:q].nil?
      @game = Game.find(params[:game_id])
    else
      @game = Game.find(params[:q][:game_id])
      review_type = params[:q][:review_type]
    end

    if params[:review_type] == "0"
      @q = @game.reviews.where(review_type: 0).ransack(params[:q])
      @review_type = 0
    elsif params[:review_type] == "1"
      @q = @game.reviews.where(review_type: 1).ransack(params[:q])
      @review_type = 1
    elsif review_type == "0"
      @q = @game.reviews.where(review_type: 0).ransack(params[:q])
      @review_type = 0
    elsif review_type == "1"
      @q = @game.reviews.where(review_type: 1).ransack(params[:q])
      @review_type = 1
    end

    if @review_type == 0
      @title = "ポジティブレビュー"
    else
      @title = "ネガティブレビュー"
    end

    @sort_select = {"いいね順" => 0, "新着順" => 1}
    sort_key = 1

    if !params[:q].nil?
      sort_key = params[:q][:choiced].to_i
    end

    @sort_prompt = 0

    if sort_key == 0
      @reviews = @q.result(distinct: true).order(count_favorites: :desc)
      @sort_prompt = 0
    elsif sort_key == 1
      @reviews = @q.result(distinct: true).order(created_at: :desc)
      @sort_prompt = 1
    end
  end

  def report
    review = Review.find(params[:review_id])
    user = review.user
    user.report = user.report + 1
    user.save
    redirect_to game_path(review.game_id)
  end

  private
  def review_params
    params.require(:review).permit(:review_type, :game_id, :review)
  end

end
