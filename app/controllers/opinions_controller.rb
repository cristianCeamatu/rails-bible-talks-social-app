class OpinionsController < ApplicationController
  before_action :require_login

  # GET /opinions
  def index
    @opinions = Opinion.all.order('created_at DESC').includes(:author)
    @users = User.all_not_followed(current_user).order('created_at DESC').includes(:followers)
    @opinion = Opinion.new
  end

  # GET /opinions/new
  def new
    @opinion = Opinion.new
  end

  # POST /opinions
  # POST /opinions.json
  def create
    @opinion = current_user.opinions.new(opinion_params)
    notice = @opinion.save ? 'Bible talk was successfully created.' : 'Bible talk not added.'

    redirect_to root_path, notice: notice
  end

  private

  # Only allow a list of trusted parameters through.
  def opinion_params
    params.require(:opinion).permit(:text)
  end

  def require_login
    return true if logged_in?

    redirect_to sign_in_path, notice: 'You must be logged in to access this section!'
  end
end
