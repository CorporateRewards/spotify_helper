class PagesController < ApplicationController
  def index; end

  def show
    render template: "pages/#{params[:page]}"
  end

  def contact; end

  def terms_and_conditions; end

  def privacy_policy; end

  def welcome
    @user = current_user || User.find_by(email: current_admin.email)
    seed_data = tracks_liked_by_user(@user)
    return unless seed_data.present?

    @recommended = RSpotify::Recommendations.generate(
      limit: 8,
      seed_tracks: seed_data
    )
  end

  def auth
    render :layout => false
  end

  def tracks_liked_by_user(user)
    user_votes = Vote.where(user_id: user).pluck(:track_id)
    return unless user_votes.present?

    Track.find(user_votes).sample(5).map(&:track_id)
  end
end
