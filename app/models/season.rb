class Season < ApplicationRecord
  has_many :squads, through: :squad_assignments
end
