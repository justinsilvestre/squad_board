require 'rails_helper'

RSpec.describe TeamMember, type: :model do
  it "is invalid without name" do
    team_member = TeamMember.create(name: nil, avatar: sample_file)

    expect(team_member).to be_invalid
  end

  it "is invalid without avatar" do
    team_member = TeamMember.create(name: "scoopy", avatar: nil)

    expect(team_member).to be_invalid
  end
end
