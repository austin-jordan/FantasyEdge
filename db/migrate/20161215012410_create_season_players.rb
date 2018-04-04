class CreateSeasonPlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :season_players do |t|
      t.string :player_name
      t.string :player_team
      t.string :position
      t.string :injury_status
      t.string :league_team
      t.decimal :minutes #:scale => 1
      t.decimal :free_throws_made #:scale => 1
      t.decimal :free_throws_attempted #:scale => 1
      t.decimal :free_throw_percentage #:scale => 3
      t.decimal :three_pointer #:scale => 1
      t.decimal :rebounds #:scale => 1
      t.decimal :assists #:scale => 1
      t.decimal :steals #:scale => 1
      t.decimal :blocks #:scale => 1
      t.decimal :points #:scale => 1
      t.decimal :free_throw_value #:scale => 1
      t.decimal :three_pointer_value #:scale => 1
      t.decimal :rebounds_value #:scale => 1
      t.decimal :assists_value #:scale => 1
      t.decimal :steals_value #:scale => 1
      t.decimal :blocks_value #:scale => 1
      t.decimal :points_value #:scale => 1
      t.decimal :player_value #:scale => 1
      t.timestamps
    end
  end
end
