class Track < ApplicationRecord
  has_many :votes
  serialize :metadata
  has_many :users, through: :votes

  def num_up_votes
    self.votes.where(:vote => true).count
  end

  def num_down_votes
    self.votes.where(:vote => false).count 
  end

  def sum_total_votes
    self.votes.where(:vote => true).count - self.votes.where(:vote => false).count
  end

  def self.sorted_by_most_votes
    Track.all.sort_by(&:sum_total_votes).reverse
  end

  def self.made_the_playlist
    # Get the top voted tracks
    @votedtracks = Track.all.where.not(metadata: nil).sort_by {|track| track.sum_total_votes}.pluck(:metadata).reverse.first(10)

    # Get new tracks added in the last 2 days
    @newtracks = Track.all.where('created_at >= ?', 2.days.ago).pluck(:metadata)

    # Return the top voted tracks and the new tracks
    @votedtracks + @newtracks
  end
end