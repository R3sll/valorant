class Agent < ApplicationRecord

  ROLES = %w[duelist initiator controller sentinel].map(&:upcase).freeze

  has_many :players
  before_validation :downcase_name

  validates :name, presence: true, length: { minimum: 1 }, uniqueness: true
  validates :description, presence: true, length: { minimum: 10 }
  validates :role, presence: true, inclusion: {in: ROLES}
  validates :ability_name, presence: true, length: { minimum: 1 }
  validates :ability_description, presence: true, length: { minimum: 10 }

  private
    def downcase_name
      self.name = name.downcase if name.present?
    end
end
