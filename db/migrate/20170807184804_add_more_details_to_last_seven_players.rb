class AddMoreDetailsToLastSevenPlayers < ActiveRecord::Migration[5.0]
  def change
    change_column :last_seven_players, :minutes, :decimal, :precision => 5, :scale => 2
    change_column :last_seven_players, :free_throws_made, :decimal, :precision => 5, :scale => 2
    change_column :last_seven_players, :free_throw_percentage, :decimal, :precision => 6, :scale => 3
    change_column :last_seven_players, :three_pointer, :decimal, :precision => 5, :scale => 2
    change_column :last_seven_players, :rebounds, :decimal, :precision => 5, :scale => 2
    change_column :last_seven_players, :assists, :decimal, :precision => 5,  :scale => 2
    change_column :last_seven_players, :steals, :decimal, :precision => 5, :scale => 2
    change_column :last_seven_players, :blocks, :decimal, :precision => 5, :scale => 2
    change_column :last_seven_players, :points, :decimal, :precision => 5, :scale => 2
  end
end
