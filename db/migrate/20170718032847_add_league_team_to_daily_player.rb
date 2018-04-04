class AddLeagueTeamToDailyPlayer < ActiveRecord::Migration[5.0]
  def change
    add_column :daily_players, :league_team, :string
  end
end
