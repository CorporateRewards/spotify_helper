class PagesController < ApplicationController
  def index; end

  def show
    render template: "pages/#{params[:page]}"
  end

  def contact; end

  def terms_and_conditions; end

  def privacy_policy; end

  def welcome; end

  def auth
    render :layout => false
  end
end
