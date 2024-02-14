class Player < ApplicationRecord
  belongs_to :agent
  belongs_to :team

  validates :nick, presence: true, length: {minimum:1}, uniqueness: true
end
