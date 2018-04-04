class DailyPlayersController < ApplicationController

  before_action :require_user, only: [:index, :show]

  def index
    @daily_players = DailyPlayer.all
    @season_players = SeasonPlayer.all
  end

end
