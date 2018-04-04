class ChangeScaleSeasonPlayers < ActiveRecord::Migration[5.0]
  def change
    change_column :daily_players, :minutes, :decimal, :precision => 4, :scale => 1
    change_column :daily_players, :free_throws_made, :decimal, :precision => 3, :scale => 1
    change_column :daily_players, :free_throw_percentage, :decimal, :precision => 4, :scale => 3
    change_column :daily_players, :three_pointers, :decimal, :precision => 3, :scale => 1
    change_column :daily_players, :rebounds, :decimal, :precision => 3, :scale => 1
    change_column :daily_players, :assists, :decimal, :precision => 3,  :scale => 1
    change_column :daily_players, :steals, :decimal, :precision => 3, :scale => 1
    change_column :daily_players, :blocks, :decimal, :precision => 3, :scale => 1
    change_column :daily_players, :points, :decimal, :precision => 4, :scale => 1
  end
end
