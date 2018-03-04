require 'rails_helper'

RSpec.describe Season, type: :model do
  it "is invalid without start and end date" do
    season = Season.new

    expect(season).to be_invalid
  end

  it "is valid with start and end date" do
    season = Season.new(start_date: Date.new, end_date: Date.new)

    expect(season).to be_valid
  end

  describe "self.current" do
    it "returns nil no current season" do
      expect(Season.current).to be_nil
    end

    it "returns season when there is a current season" do
      season = Season.create!(start_date: Time.now - 14.days, end_date: Time.now + 14.days)

      expect(Season.current).to eq season
    end
  end
end
