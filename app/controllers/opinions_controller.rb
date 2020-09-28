class OpinionsController < ApplicationController
  before_action :require_login

  def index
    @opinions = Opinion.all_followed_by(current_user).order('created_at DESC').includes(:author)
    @users = User.all_not_followed(current_user).order('created_at DESC').includes(:followers)
    @opinion = Opinion.new
  end

  def new
    @opinion = Opinion.new
  end

  def create
    @opinion = current_user.opinions.new(opinion_params)
    notice = @opinion.save ? 'Bible talk was successfully created.' : 'Bible talk not added.'

    redirect_to root_path, notice: notice
  end

  private

  def opinion_params
    params.require(:opinion).permit(:text)
  end
end
