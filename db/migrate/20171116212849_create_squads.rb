class CreateSquads < ActiveRecord::Migration[5.1]
  def change
    create_table :squads do |t|
      t.references :season, foreign_key: true

      t.timestamps
    end
  end
end
