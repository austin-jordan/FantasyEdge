class CreateTrades < ActiveRecord::Migration[5.0]
  def change
    create_table :trades do |t|
      t.string :date
      t.time :time
      t.string :team_name_out
      t.string :player_traded
      t.string :team_name_in
      t.timestamps
    end
  end
end
