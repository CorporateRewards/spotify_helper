class PagesController < ApplicationController
  def index
    @playlist = playlist
  end

  def show
    render template: "pages/#{params[:page]}"
  end

  def contact; end

  def terms_and_conditions; end

  def privacy_policy; end

  def welcome
    @user = current_user || User.find_by(email: current_admin.email)
    @recommended = RSpotify::Recommendations.generate(limit: 10,
                                                      seed_tracks: tracks_liked_by_user(@user).map(&:track_id)
                                                     )
    @recommendations = @recommended.tracks
  end

  def tracks_liked_by_user(user)
    user_votes = Vote.where(user_id: user).pluck(:track_id)
    Track.find(user_votes).sample(5)
  end
end
