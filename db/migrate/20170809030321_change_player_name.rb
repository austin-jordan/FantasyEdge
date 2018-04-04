class ChangePlayerName < ActiveRecord::Migration[5.0]
  def change
    add_index :last_seven_players, [:player_name, :player_team], unique: true
    add_index :season_players, [:player_name, :player_team], unique: true
    add_index :daily_players, [:player_name, :player_team], unique: true
  end
end
