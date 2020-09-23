class FrontendController < ApplicationController
  def index
    @opinion = Opinion.new
  end

  def show
    @opinion = Opinion.new
    @following = Following.new
  end
end
