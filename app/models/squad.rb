class Squad < ApplicationRecord
  belongs_to :season
  has_many :team_members, through: :squad_assignments
end
