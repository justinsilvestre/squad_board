class AddAttachmentAvatarToTeamMembers < ActiveRecord::Migration[5.1]
  def self.up
    change_table :team_members do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :team_members, :avatar
  end
end
