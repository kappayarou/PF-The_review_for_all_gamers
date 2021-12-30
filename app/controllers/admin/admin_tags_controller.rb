class Admin::AdminTagsController < ApplicationController

  before_action :admin_judgement

  def admin_judgement
    if !admin_signed_in?
      redirect_to root_path
    end
  end

  def create
    admin_tag = AdminTag.new(admin_tag_params)
    admin_tag.save
    redirect_to admin_games_path
  end


  private
  def admin_tag_params
    params.require(:admin_tag).permit(:tag)
  end

end
