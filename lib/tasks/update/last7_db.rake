namespace :update do

  desc 'Update last7 table with updated stats'
  task last7: :environment do
    LastSevenPlayer.refresh_last7()
  end
end
