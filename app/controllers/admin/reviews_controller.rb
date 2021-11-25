class Admin::ReviewsController < ApplicationController

  def index
    if params[:review_type] == 0
      @reviews = Review.where(review_type: 0)
    elsif params[:review_type] == 1
      @reviews = Review.where(review_type: 1)
    end
  end

end
