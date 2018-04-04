# encoding: UTF-8
require 'rubygems'
require 'open-uri'
require 'watir'
require 'nokogiri'
require 'csv'

@browser = Watir::Browser.new :chrome
@browser.goto 'http://games.espn.com/fba/tools/draftrecap?leagueId=219403'
#@browser.goto 'http://games.espn.com/fba/freeagency?leagueId=219403&teamId=2&seasonId=2017#&seasonId=2017&avail=-1&context=freeagency&view=stats&version=currSeason&startIndex=0'
#sleep 5
sign = @browser.iframe(:name, 'disneyid-iframe')
sign.exists?
a = sign.text_field(:xpath => '//*[@id="did-ui"]/div/div/section/section/form/section/div[1]/div/label/span[2]/input')
a.exists?
a.set 'austin.j4106@gmail.com'
sign.text_field(:xpath => '//*[@id="did-ui"]/div/div/section/section/form/section/div[2]/div/label/span[2]/input').set 'soccer10!'
sign.button(:xpath => '//*[@id="did-ui"]/div/div/section/section/form/section/div[3]/button').click
sleep 5
page_html = @browser.html
nokogiri_object = Nokogiri::HTML.parse(page_html)
nokogiri_object.css('tbody tr.tableBody').each do |tr|
  stats = tr.css('td')
  draft_spot = stats[0].text
  player_name = stats[1].text
  player_info = stats[2].text
  #team_name = player_info.css('td a.flexpop').text
  team_name = player_info.text.split(",")[0]
  #player_team = player_info.split(",")[1]
  puts draft_spot + " " + player_name + " " + team_name
end
