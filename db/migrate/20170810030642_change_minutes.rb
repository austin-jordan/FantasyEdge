class ChangeMinutes < ActiveRecord::Migration[5.0]
  def change
    change_column :last_seven_players, :minutes, :decimal, :precision => 4, :scale => 2
    change_column :season_players, :minutes, :decimal, :precision => 4, :scale => 2
    change_column :daily_players, :minutes, :decimal, :precision => 4, :scale => 2
  end
end
