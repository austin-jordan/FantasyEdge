class AddPlayerValueToSeasonPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :season_players, :player_value, :decimal, :precision => 3,  :scale => 1
    add_column :last_seven_players, :player_value, :decimal, :precision => 3,  :scale => 1
  end
end
