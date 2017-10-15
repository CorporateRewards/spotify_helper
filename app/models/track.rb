class Track < ApplicationRecord
  has_many :votes

  def num_up_votes
    self.votes.where(:vote => true).count
  end

  def num_down_votes
    self.votes.where(:vote => false).count 
  end

  def sum_total_votes
    self.votes.where(:vote => true).count - self.votes.where(:vote => false).count
  end

end