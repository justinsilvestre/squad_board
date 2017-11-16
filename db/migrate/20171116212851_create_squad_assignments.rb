class CreateSquadAssignments < ActiveRecord::Migration[5.1]
  def change
    create_table :squad_assignments do |t|
      t.references :team_member, foreign_key: true
      t.references :squad, foreign_key: true

      t.timestamps
    end
  end
end
