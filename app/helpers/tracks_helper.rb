module TracksHelper
  def users_vote_on_track(track, vote)
    track_vote = @user.votes.where(track_id: track.id, vote: vote)
    if track_vote.present?
      'disabled'
    else
      'active'
    end
  end
end
