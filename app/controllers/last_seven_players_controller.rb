class LastSevenPlayersController < ApplicationController
  def index
    @last_seven_players = LastSevenPlayer.all
  end
end
