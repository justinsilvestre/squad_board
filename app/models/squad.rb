class Squad < ApplicationRecord
  has_one :season
  has_many :squad_assignments, dependent: :destroy
  has_many :team_members, through: :squad_assignments

  def elm
    {
      name: 'Squidsquad',
      team_members: team_members.map(&:id).map(&:to_s)
    }
  end
end
