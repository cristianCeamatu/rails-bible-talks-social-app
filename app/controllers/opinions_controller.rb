class OpinionsController < ApplicationController
  before_action :require_login
  before_action :set_opinion, only: %i[show edit update destroy]

  # GET /opinions
  def index
    @opinions = Opinion.all.order('created_at DESC')
    @users = User.all_except(current_user).order('created_at DESC')
    @opinion = Opinion.new
  end

  # GET /opinions/1
  def show; end

  # GET /opinions/new
  def new
    @opinion = Opinion.new
  end

  # GET /opinions/1/edit
  def edit; end

  # POST /opinions
  # POST /opinions.json
  def create
    @opinion = current_user.opinions.new(opinion_params)

    if @opinion.save
      redirect_to root_path, notice: 'Bible talk was successfully created.'
    else
      render :new, notice: 'Bible talk not added.'
    end
  end

  # PATCH/PUT /opinions/1
  def update
    respond_to do |format|
      if @opinion.update(opinion_params)
        format.html { redirect_to @opinion, notice: 'Opinion was successfully updated.' }
        format.json { render :show, status: :ok, location: @opinion }
      else
        format.html { render :edit }
        format.json { render json: @opinion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /opinions/1
  def destroy
    @opinion.destroy
    respond_to do |format|
      format.html { redirect_to opinions_url, notice: 'Opinion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_opinion
    @opinion = Opinion.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def opinion_params
    params.require(:opinion).permit(:text)
  end

  def require_login
    unless logged_in?
      flash.notice = 'You must be logged in to access this section!'
      redirect_to sign_in_path
    end
  end
end
