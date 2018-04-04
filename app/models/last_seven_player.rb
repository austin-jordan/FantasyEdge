require 'csv'
require "activerecord-import/base"
ActiveRecord::Import.require_adapter('mysql2')
ActiveRecord::Import.require_adapter('mysql2')
class LastSevenPlayer < ApplicationRecord

  def self.find_injured_players
    where.not(injury_status: '').pluck(:player_name, :injury_status)
  end

  def self.find_injured_teams
    where.not(injury_status: '').group(:league_team).order('count_all desc').count
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

  def self.update_free_throws_value
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

  def self.refresh_last7
    columns = [ :player_name, :player_team, :position, :injury_status, :league_team, :minutes, :free_throws_made, :free_throws_attempted, :free_throw_percentage, :three_pointers, :rebounds, :assists, :steals, :blocks, :points ]
    values = CSV.read(File.dirname(__FILE__) + '/last7.csv')
    values.shift

    import columns, values, validate: false, on_duplicate_key_update: [ :injury_status, :minutes, :free_throws_made, :free_throws_attempted, :free_throw_percentage, :three_pointers, :rebounds, :assists, :steals, :blocks, :points]
  end
  #def self.refresh_last7
   #  CSV.foreach(File.dirname(__FILE__) + '/last7.csv', :headers => true) do |row|
    #  update(row.to_hash)
    # end
  #end
end