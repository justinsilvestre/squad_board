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
end
