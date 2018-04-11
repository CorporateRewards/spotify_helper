class Nickname < ApplicationRecord
  belongs_to :user
  validates_presence_of :nickname 
  validates_uniqueness_of :nickname
  validates_length_of :nickname, {
  	in: 2..20, 
  	too_short:"is too short! Minimum 2 characters please! 1 character can't be a nickname come on",
  	too_long:"is too long. 20 characters should be enough."
  }
  @exclusions = [
  	'god',
  	'omnipotent',
  	'omniscient',
  	'nazi',
  	'hitler'
  ]
  @exclusions_for_regex = Regexp.new '(' + @exclusions.join("|").to_s + ')'
  validates_format_of :nickname,{
  	without: @exclusions_for_regex,
  	message: "do not think you are %{value}"
  }

end
