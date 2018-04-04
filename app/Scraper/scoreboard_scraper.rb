# encoding: UTF-8
require 'rubygems'
require 'open-uri'
require 'watir'
require 'nokogiri'
require 'csv'

@browser = Watir::Browser.new :chrome
@browser.goto 'http://games.espn.com/fba/scoreboard?leagueId=219403&seasonId=2017'
#@browser.goto 'http://games.espn.com/fba/freeagency?leagueId=219403&teamId=2&seasonId=2017#&seasonId=2017&avail=-1&context=freeagency&view=stats&version=currSeason&startIndex=0'
#sleep 5
sign = @browser.iframe(:name, 'disneyid-iframe')
sign.exists?
a = sign.text_field(:xpath => '//*[@id="did-ui"]/div/div/section/section/form/section/div[1]/div/label/span[2]/input')
a.exists?
a.set 'austin.j4106@gmail.com'
sign.text_field(:xpath => '//*[@id="did-ui"]/div/div/section/section/form/section/div[2]/div/label/span[2]/input').set 'soccer10!'
#sign.button(:xpath => '//*[@id="did-ui"]/div/div/section/section/form/section/div[3]/button').click
sign.button(:css => 'button.btn.btn-primary.btn-submit.ng-binding').click
sleep 5
page_html = @browser.html
nokogiri_object = Nokogiri::HTML.parse(page_html)
scoreboard_data = []
nokogiri_object.css('tr.linescoreTeamRow').each_with_index do |tr, i|
#  def findMatchupID
#    if i % 2 = 0
#      matchup_id = i / 2
#    end  
  team_name = tr.css('td.teamName a').text
  stats = tr.xpath('//td[starts-with(@id, "ls_tmTotalStat")]')
  free_throw_percentage = stats[0]
  three_pointers = stats[1]
  rebounds = stats[2]
  assists = stats[3]
  steals = stats[4]
  blocks = stats[5]
  points = stats[6]
  score = tr.xpath('//td[starts-with(@id, "h2hcattotal")]')[i].text
  scoreboard_data << [team_name, free_throw_percentage, three_pointers, rebounds, assists, steals, blocks, points, score]
  puts team_name + " " + free_throw_percentage + " " + three_pointers + " " + rebounds + " " + assists + " " + steals + " " + blocks + " " + points + " " + score
end
CSV.open('scoreboard.csv', 'wb') do |row|
  row << ['team_name', 'free_throw_percentage', 'three_pointers', 'rebounds', 'assists', 'steals', 'blocks', 'points', 'score']
      scoreboard_data.each do |data|
        row << data
      end
end
