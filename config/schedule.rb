# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron
#every 5.minutes do
every :day, at: '7am' do
  command 'rm /Users/austinjordan/Documents/FantasyEdgeApp/daily.csv'
  command 'rm /Users/austinjordan/Documents/FantasyEdgeApp/scoreboard.csv'
  command 'rm /Users/austinjordan/Documents/FantasyEdgeApp/trades.csv'
  rake 'scrape:daily'
  rake 'scrape:scoreboard'
  rake 'scrape:trade'
end

every :day, at: '7am' do
  command 'rm all_season.csv'
  command 'rm last7.csv'
  rake 'scrape:all_season'
  rake 'scrape:last7'
end
# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
