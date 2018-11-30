class PagesController < ApplicationController

  def index
    @playlist = playlist
  end

  def show
    render template: "pages/#{params[:page]}"
  end

  def contact

  end

  def terms_and_conditions

  end

  def privacy_policy

  end

end
