class Squad < ApplicationRecord
  belongs_to :season
  has_many :squad_assignments, dependent: :destroy
  has_many :team_members, through: :squad_assignments

  validates :team_members, length: { minimum: 1 }
end
