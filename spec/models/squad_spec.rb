require 'rails_helper'

RSpec.describe Squad, type: :model do
  team_members = [0...25].map do |n|
    TeamMember.create!(name: "member#{n}", avatar: sample_file)
  end

  seasons = [0...5].map do |n|
    Season.create!(start_date: Date.new, end_date: Date.new)
  end

  it "is valid with season and members" do
    season = seasons.first
    squad = Squad.create(season: season, team_members: team_members)

    expect(squad).to be_valid
  end
end
