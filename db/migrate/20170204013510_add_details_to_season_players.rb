class AddDetailsToSeasonPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :season_players, :free_throw_value, :decimal #:scale => 2
    add_column :season_players, :three_pointer_value, :decimal #:scale => 2
    add_column :season_players, :rebounds_value, :decimal #:scale => 2
    add_column :season_players, :assists_value, :decimal #:scale => 2
    add_column :season_players, :steals_value, :decimal #:scale => 2
    add_column :season_players, :blocks_value, :decimal #:scale => 2
    add_column :season_players, :points_value, :decimal #:scale => 2
  end
end
