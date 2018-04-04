class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    redirect_to '/login' unless current_user
  end
  #separating players in league
  #find the average per column
  #find the standard deviation per column
  #find average for players in the league
  #get whatever player is averaging - average for players in league / standard_deviation
  #first part is the same for free throws
  #layer in how many they take then divide it by the league average for amount of fts taken
  #multiply first part by second part
  #see 7 stats next to the player then value next to the stats
  #field goal percentage is the same as free_throws

  #league power rankings
  #add up player values for each category

end
