require 'csv'

desc "Save parsed season player stats to database"
task :save_season_stats do
#  CSV.foreach(('all_season.csv'), :headers => true) do |row|
  CSV.foreach(File.dirname(__FILE__) + '/all_season.csv', :headers => true) do |row|
    require "#{Rails.root}/app/models/season_player"
    SeasonPlayer.create!(row.to_hash)
  end
end
