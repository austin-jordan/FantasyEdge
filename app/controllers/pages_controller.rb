class PagesController < ApplicationController
  def home
    @title = "League Feed"
  end

  def matchup
    @title = "Matchup Tab"
  end

  def trades
    @title = "Trade Analyzer"
  end

end
