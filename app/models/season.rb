class Season < ApplicationRecord
  has_many :squad_assignments, dependent: :destroy
  has_many :squads, through: :squad_assignments, dependent: :destroy

  validates :start_date, presence: true
  validates :end_date, presence: true

  def self.current
    Season.where("start_date < ? AND end_date > ?", Time.now, Time.now).first
  end
end
