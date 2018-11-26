class Track < ApplicationRecord
  has_many :votes, dependent: :destroy
  serialize :metadata
  has_many :users, through: :votes
  validates :track_id, uniqueness: true
  validates :metadata, presence: true

  def num_up_votes
    votes.where(vote: true).count
  end

  def num_down_votes
    votes.where(vote: false).count
  end

  def sum_total_votes
    votes.where(vote: true).count - votes.where(vote: false).count
  end

  def self.sorted_by_most_votes
    Track.all.sort_by(&:sum_total_votes).reverse
  end

  def self.made_the_playlist
    # Get the top voted tracks
    @votedtracks = Track.all.where.not(metadata: nil)
      .where.not('created_at >= ?', 2.days.ago)
      .sort_by(&:sum_total_votes)
      .pluck(:metadata)
      .reverse.first(80)

    # Get new tracks added in the last 2 days
    @newtracks = Track.all.where('created_at >= ?', 2.days.ago).pluck(:metadata)

    # Return the top voted tracks and the new tracks
    @new_playlist = @votedtracks + @newtracks
  end
end
