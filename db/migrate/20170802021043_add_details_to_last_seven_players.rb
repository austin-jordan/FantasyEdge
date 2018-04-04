class AddDetailsToLastSevenPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :last_seven_players, :free_throw_value, :decimal, :precision => 5, :scale => 2
    add_column :last_seven_players, :points_value, :decimal, :precision => 5, :scale => 2
    add_column :last_seven_players, :three_pointer_value, :decimal, :precision => 5, :scale => 2
    add_column :last_seven_players, :points_value, :decimal, :precision => 5, :scale => 2
    add_column :last_seven_players, :rebounds_value, :decimal, :precision => 5, :scale => 2
    add_column :last_seven_players, :points_value, :decimal, :precision => 5, :scale => 2
    add_column :last_seven_players, :assists_value, :decimal, :precision => 5, :scale => 2
    add_column :last_seven_players, :points_value, :decimal, :precision => 5, :scale => 2
    add_column :last_seven_players, :steals_value, :decimal, :precision => 5, :scale => 2
    add_column :last_seven_players, :points_value, :decimal, :precision => 5, :scale => 2
    add_column :last_seven_players, :blocks_value, :decimal, :precision => 5, :scale => 2
    add_column :last_seven_players, :points_value, :decimal, :precision => 5, :scale => 2
  end
end
