class UserController < ApplicationController

  def mypage
    @user = current_user

    @follows = @user.follows

    suggests = []
    @follows.each do |follow|
      user = User.find(follow.follow)
      high_ratings = user.ratings.where("rating > 4")
      high_ratings.each do |rate|
        suggests.append(rate.game_id)
      end
    end
    @suggest_games = []
    suggests.each do |suggest|
      game = Game.find(suggest)
      @suggest_games.append(game)
    end

    reviews = @user.reviews
    favorites_count = []
    reviews.each do |review|
      favorites_count.append(review.favorites.count)
    end

    need_exp = ((@user.rank - 1) ** 2) * 4 + 100
    review_exp = 100 - ((@user.reviews.count ** 2) / 25)
    favorite_ratio_exp = 5000 * (favorites_count.count / reviews.count)
    favorite_count_exp = 100 * favorites_count.count

  end

  def edit
  end

  def show
    @sort_select = {"評価順" => 0, "新着順" => 1}
    @user = User.find(params[:id])

    sort_key = 1

    if params[:choiced]
      sort_key = params[:choiced].to_i
    end

    @sort_prompt = 0

    @q = Game.joins(ratings: :user).where(id: @user.id).ransack(params[:q])

    if sort_key == 0
      @games = @q.result(distinct: true).order(rating: :desc).limit(10)
      @sort_prompt = 0
    elsif sort_key == 1
      @games = @q.result(distinct: true).order(created_at: :desc).limit(10)
      @sort_prompt = 1
    end

    select_review = 2
    @review_type = {"ポジティブレビュー": 0, "ネガティブレビュー": 1}
    @review_prompt = 0

    if params[:select_review]
      select_review = params[:select_review].to_i
    end

    @all_reviews = []
    if select_review == 0
      @all_reviews = @user.reviews.where(review_type: 0)
      @review_prompt = 0
    elsif  select_review == 1
      @all_reviews = @user.reviews.where(review_type: 1)
      @review_prompt = 1
    end

    @follows = @user.follows

  end

end
