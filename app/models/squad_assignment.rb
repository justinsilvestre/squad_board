class SquadAssignment < ApplicationRecord
  belongs_to :team_member
  belongs_to :squad
  has_one :season, through: :squad
end
