class Admin::ReviewsController < ApplicationController

  before_action :admin_judgement

  def admin_judgement
    if !admin_signed_in?
      redirect_to root_path
    end
  end

  def index
    if params[:review_type] == 0
      @reviews = Review.where(review_type: 0)
    elsif params[:review_type] == 1
      @reviews = Review.where(review_type: 1)
    end
  end

end
