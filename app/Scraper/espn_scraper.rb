require 'rubygems'
require 'open-uri'
require 'watir'
require 'nokogiri'

@browser = Watir::Browser.new :chrome
@browser.goto 'http://games.espn.com/fba/leagueoffice?leagueId=219403'
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
#team_elements = doc.li(:xpath => '//ul/li[@class=recent-activity-description]/a').text
nokogiri_object = Nokogiri::HTML.parse(page_html)
team_elements = nokogiri_object.css('li.lo-recent-activity-item ul li.recent-activity-description a')
transaction_elements = nokogiri_object.css('li.lo-recent-activity-item ul li.recent-activity-description b')
puts team_elements.length
  team_elements.each do |team_element|
   puts team_element.text
  end
  transaction_elements.each do |transaction_element|
    puts transaction_element.text
  end
