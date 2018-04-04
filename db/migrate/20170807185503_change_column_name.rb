class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :season_players, :three_pointer, :three_pointers
    rename_column :daily_players, :three_pointer, :three_pointers
    rename_column :last_seven_players, :three_pointer, :three_pointers
  end
end
