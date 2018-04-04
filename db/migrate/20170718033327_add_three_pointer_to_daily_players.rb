class AddThreePointerToDailyPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :daily_players, :three_pointer, :decimal
  end
end
