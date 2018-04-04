class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.string :date
      t.string :team_name
      t.string :action
      t.string :player_name
      t.timestamps
    end
  end
end
