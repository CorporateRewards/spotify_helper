class Nickname < ApplicationRecord

  def self.nickname_exclusions # Definition *MUST* be before caller.
    @exclusions = BannedPhrases.distinct.to_a.map{ |bp| bp.phrase}.join("|").to_s
    return /\b(#{@exclusions})\b/im
  end

  belongs_to :user, optional: true
  validates :nickname,
    presence: true,
    uniqueness: true,
    length: {
      in: 2..20,
      too_short: 'Your nickname is too short! Minimum 2 characters please!',
      too_long: 'Your nickname is too long. 20 characters should be enough.'
    },
    format: {
      without: nickname_exclusions,
      message: 'Your nickname cannot be %{value}'
    }
end
