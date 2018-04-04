require 'csv'
require "activerecord-import/base"
ActiveRecord::Import.require_adapter('mysql2')
ActiveRecord::Import.require_adapter('mysql2')
class SeasonPlayer < ApplicationRecord

  def self.find_points_avg
    average(:points)
  end

  def self.find_assists_avg
    average(:assists)
  end

  def self.find_rebounds_avg
    average(:rebounds)
  end

  def self.find_steals_avg
    average(:steals)
  end

  def self.find_blocks_avg
    average(:blocks)
  end

  def self.find_player_value_points
    player_averages = pluck(:points)
    league_average = average(:points)
    standard_dev = select('stddev_samp(points) as stdev').first['stdev']
    player_values = []
    player_averages.each do |player_average|
      #player_values << ((player_average - league_average) / standard_dev).to_s
      player_values << "%.2f" % ((player_average - league_average) / standard_dev)
      #return player_value
    end
    return player_values
  end

  def self.find_player_value_assists
    player_averages = pluck(:assists)
    league_average = average(:assists)
    standard_dev = select('stddev_samp(assists) as stdev').first['stdev']
    player_values = []
    player_averages.each do |player_average|
      player_values << ((player_average - league_average) / standard_dev)
      #player_values << "%.2f" % ((player_average - league_average) / standard_dev)
    end
    return player_values
  end

  def self.find_player_value_rebounds
    player_averages = pluck(:rebounds)
    league_average = average(:rebounds)
    standard_dev = select('stddev_samp(rebounds) as stdev').first['stdev']
    player_values = []
    player_averages.each do |player_average|
      player_values << ((player_average - league_average) / standard_dev)
      #player_values << "%.2f" % ((player_average - league_average) / standard_dev)
    end
    return player_values
  end

  def self.find_player_value_steals
    player_averages = pluck(:steals)
    league_average = average(:steals)
    standard_dev = select('stddev_samp(steals) as stdev').first['stdev']
    player_values = []
    player_averages.each do |player_average|
      player_values << ((player_average - league_average) / standard_dev)
      #player_values << "%.2f" % ((player_average - league_average) / standard_dev)
    end
    return player_values
  end

  def self.find_player_value_blocks
    player_averages = pluck(:blocks)
    league_average = average(:blocks)
    standard_dev = select('stddev_samp(blocks) as stdev').first['stdev']
    player_values = []
    player_averages.each do |player_average|
      player_values << ((player_average - league_average) / standard_dev)
      #player_values << "%.2f" % ((player_average - league_average) / standard_dev)
    end
    return player_values
  end

  def self.find_player_value_three_pointers
    player_averages = pluck(:three_pointers)
    league_average = average(:three_pointers)
    standard_dev = select('stddev_samp(three_pointers) as stdev').first['stdev']
    player_values = []
    player_averages.each do |player_average|
      player_values << ((player_average - league_average) / standard_dev)
      #player_values << "%.2f" % ((player_average - league_average) / standard_dev)
    end
    return player_values
  end

  def self.find_free_throw_percentage
    free_throw_makes = pluck(:free_throws_made)
    free_throw_attempts = pluck(:free_throws_attempted)
    free_throw_percentages = []
    free_throw_makes.zip(free_throw_attempts).each do |free_throw_make, free_throw_attempt|
      if ((free_throw_make / free_throw_attempt).is_a?(BigDecimal) && (free_throw_make / free_throw_attempt).nan?)
        free_throw_percentage = 0
      else
        free_throw_percentage = free_throw_make / free_throw_attempt
      end
      free_throw_percentages << free_throw_percentage
    end
    return free_throw_percentages
  end

  def self.update_free_throw_percentage
    find_free_throw_percentage.each_with_index do |free_throw, index|
      update((index + 1), free_throw_percentage: free_throw)
    end
  end

  def self.find_raw_free_throw_percentage
    player_averages = pluck(:free_throw_percentage)
    league_average = average(:free_throw_percentage)
    standard_dev = select('stddev_samp(steals) as stdev').first['stdev']
    raw_free_throw_percentage = []
    player_averages.each do |player_average|
      raw_free_throw_percentage << ((player_average - league_average) / standard_dev)
      #player_values << "%.2f" % ((player_average - league_average) / standard_dev)
    end
    return raw_free_throw_percentage
  end

  def self.find_free_throw_attempts_percentage
    player_averages = pluck(:free_throws_attempted)
    league_average = average(:free_throws_attempted)
    free_throw_attempts_percentage = []
    player_averages.each do |player_average|
      free_throw_attempts_percentage << (player_average / league_average)
    end
    return free_throw_attempts_percentage
  end

  def self.find_free_throws_value
    raw_free_throw_percentages = find_raw_free_throw_percentage
    free_throw_attempts_percentages = find_free_throw_attempts_percentage
    player_values = []
    raw_free_throw_percentages.zip(free_throw_attempts_percentages).each do |raw_free_throw_percentage, free_throw_attempts_percentage|
      player_values << raw_free_throw_percentage * free_throw_attempts_percentage
    end
    return player_values
  end

  def self.find_player_value_total
    query = <<-SQL
      SELECT id,( free_throw_value + three_pointer_value + rebounds_value + assists_value + steals_value + blocks_value + points_value )
      AS value_total
      FROM season_players
    SQL
    find_by_sql(query)
  end

  def self.find_player_value_totals
    player_values = []
    totals = find_player_value_total.map(&:value_total)
    totals.each do |total|
      player_values << total
    end
    return player_values
  end

  def self.find_player_value
    player_values = where.not(:league_team =>'').pluck(:id, :player_name, :league_team, :player_value)
    return player_values
  end

  def self.find_lowest_player_value
    lowest_player_values = find_player_value.sort_by{|id, player_name, league_team, player_value| player_value }.first(5)
    return lowest_player_values
  end

  def self.find_team_player_values
    totals = []
    team_totals = select(:league_team).group(:league_team).sum(:player_value)
    league_teams = team_totals.sort_by {|league_team, sum_player_value| sum_player_value }.reverse
    league_teams.each do |league_team|
      totals << league_team
    end
     #totals << where(:league_team => "#{league_team}").sum(:player_value)
    #end
    #return totals
    return totals
  end

  #ef self.find_team_totals

  #end

def self.update_free_throws_values
  find_free_throws_value.each_with_index do |free_throw, index|
    update((index + 1), free_throw_value: free_throw)
  end
end

def self.update_points_value
  find_player_value_points.each_with_index do |point, index|
    update((index + 1), points_value: point)
  end
end

def self.update_assists_value
  find_player_value_assists.each_with_index do |assist, index|
    update((index + 1), assists_value: assist)
  end
end

def self.update_rebounds_value
  find_player_value_rebounds.each_with_index do |rebound, index|
    update((index + 1), rebounds_value: rebound)
  end
end

def self.update_steals_value
  find_player_value_steals.each_with_index do |steal, index|
    update((index + 1), steals_value: steal)
  end
end

def self.update_blocks_value
  find_player_value_blocks.each_with_index do |block, index|
    update((index + 1), blocks_value: block)
  end
end

def self.update_three_pointer_value
  find_player_value_three_pointers.each_with_index do |three_pointer, index|
    update((index + 1), three_pointer_value: three_pointer)
  end
end

def self.update_player_value
  find_player_value_totals.each_with_index do |total, index|
    update((index + 1), player_value: total)
  end
end

def self.refresh_season_player
  columns = [:player_name, :player_team, :position, :injury_status, :league_team, :minutes, :free_throws_made, :free_throws_attempted, :free_throw_percentage, :three_pointers, :rebounds, :assists, :steals, :blocks, :points]
  values = CSV.read(File.dirname(__FILE__) + '/all_season.csv')
  values.shift

  import columns, values, validate: false, on_duplicate_key_update: [:injury_status, :minutes, :free_throws_made, :free_throws_attempted, :free_throw_percentage, :three_pointers, :rebounds, :assists, :steals, :blocks, :points]
end

end