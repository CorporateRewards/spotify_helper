class Vote < ApplicationRecord
  belongs_to :track, touch: true
  belongs_to :user
end