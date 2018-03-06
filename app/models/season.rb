class Season < ApplicationRecord
  has_many :squads, dependent: :destroy

  validates :start_date, presence: true
  validates :end_date, presence: true

  def self.current
    Season.where("start_date < ? AND end_date > ?", Time.now, Time.now)
          .first
  end

  def self.new_season_tray
    penultimate_season = Season.order(:start_date)[-2]
    penultimate_season.nil? ? [] : penultimate_season.elm_team_members
  end

  def elm
    {
      start: self.start_date,
      end: self.end_date,
      # squads: []
      squads: self.squads.map(&:elm)
    }
  end

  def elm_team_members
    team_members.map(&:elm)
  end

  def previous
    Season.where("start_date < ?", start_date)
          .order(:start_date)
          .last
  end

  def team_members
    squads.flat_map { |squad| squad.team_members }.uniq
  end
end
