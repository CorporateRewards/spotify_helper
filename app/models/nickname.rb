class Nickname < ApplicationRecord

  def self.nickname_exclusions # Definition *MUST* be before caller.
    @exclusions = BannedPhrases.uniq.to_a.map{ |bp| bp.phrase}.join("|").to_s
    return /(#{@exclusions})/im
  end

  belongs_to :user
  validates_presence_of :nickname
  validates_uniqueness_of :nickname
  validates_length_of :nickname, {
    in: 2..20,
    too_short:"is too short! Minimum 2 characters please! 1 character can't be a nickname come on",
    too_long:"is too long. 20 characters should be enough."
  }

  # Method `nickname_exclusions` is called after definition
  validates_format_of :nickname, without: nickname_exclusions, message: "You cannot be %{value}"

end