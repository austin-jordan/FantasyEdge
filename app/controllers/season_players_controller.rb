class SeasonPlayersController < ApplicationController

  before_action :require_user, only: [:index, :show]

  def index
    @season_players = SeasonPlayer.all
  end
end
