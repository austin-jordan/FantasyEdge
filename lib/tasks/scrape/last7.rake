namespace :scrape do
  desc 'Scrape last seven day data from the ESPN site'
  task :last7 => :environment do
#    LastSevenScraper.parse_last7()
  @browser = Watir::Browser.new :chrome
  @browser.goto 'http://games.espn.com/fba/freeagency?leagueId=219403&teamId=2&seasonId=2017#&seasonId=2017&avail=-1&context=freeagency&view=stats&version=last7&startIndex=0&scoringPeriodId=49'
  sign = @browser.iframe(:name, 'disneyid-iframe')
  sign.exists?
  a = sign.text_field(:xpath => '//*[@id="did-ui"]/div/div/section/section/form/section/div[1]/div/label/span[2]/input')
  a.exists?
  a.set 'austin.j4106@gmail.com'
  sign.text_field(:xpath => '//*[@id="did-ui"]/div/div/section/section/form/section/div[2]/div/label/span[2]/input').set 'soccer10!'
  sign.button(:xpath => '//*[@id="did-ui"]/div/div/section/section/form/section/div[3]/button').click
  sleep 5
  @browser.link(:name => 'avail', :index => 0).click
  sleep 5
  @browser.link(:xpath => '//*[@id="ptfiltersmenuleft"]/div[2]/a').click
  sleep 5
  page_html = @browser.html
  @browser.link(:xpath => '//*[@id="playerTableContainerDiv"]/table[2]/tbody/tr[2]/td/div/a').click
  sleep 3
  page_html2 = @browser.html
  @browser.link(:xpath => '//*[@id="playerTableContainerDiv"]/table[2]/tbody/tr[2]/td/div/a[2]').click
  sleep 3
  page_html3 = @browser.html
  @browser.link(:xpath => '//*[@id="playerTableContainerDiv"]/table[2]/tbody/tr[2]/td/div/a[2]').click
  sleep 3
  page_html4 = @browser.html
  @browser.link(:xpath => '//*[@id="playerTableContainerDiv"]/table[2]/tbody/tr[2]/td/div/a[2]').click
  sleep 3
  page_html5 = @browser.html
  @browser.link(:xpath => '//*[@id="playerTableContainerDiv"]/table[2]/tbody/tr[2]/td/div/a[2]').click
  sleep 3
  page_html6 = @browser.html
  @browser.link(:xpath => '//*[@id="playerTableContainerDiv"]/table[2]/tbody/tr[2]/td/div/a[2]').click
  sleep 3
  page_html7 = @browser.html
  @browser.link(:xpath => '//*[@id="playerTableContainerDiv"]/table[2]/tbody/tr[2]/td/div/a[2]').click
  sleep 3
  page_html8 = @browser.html
  @browser.link(:xpath => '//*[@id="playerTableContainerDiv"]/table[2]/tbody/tr[2]/td/div/a[2]').click
  sleep 3
  page_html9 = @browser.html
  @browser.link(:xpath => '//*[@id="playerTableContainerDiv"]/table[2]/tbody/tr[2]/td/div/a[2]').click
  sleep 3
  page_html10 = @browser.html
  @browser.link(:xpath => '//*[@id="playerTableContainerDiv"]/table[2]/tbody/tr[2]/td/div/a[2]').click
  sleep 3
  page_html11 = @browser.html
  @browser.link(:xpath => '//*[@id="playerTableContainerDiv"]/table[2]/tbody/tr[2]/td/div/a[2]').click
  sleep 3
  page_html12 = @browser.html
  @browser.link(:xpath => '//*[@id="playerTableContainerDiv"]/table[2]/tbody/tr[2]/td/div/a[2]').click
  sleep 3
  page_html13 = @browser.html
  @browser.link(:xpath => '//*[@id="playerTableContainerDiv"]/table[2]/tbody/tr[2]/td/div/a[2]').click
  sleep 3
  page_html14 = @browser.html
  @browser.link(:xpath => '//*[@id="playerTableContainerDiv"]/table[2]/tbody/tr[2]/td/div/a[2]').click
  sleep 3
  page_html15 = @browser.html
    nokogiri_objects = [Nokogiri::HTML.parse(page_html), Nokogiri::HTML.parse(page_html2), Nokogiri::HTML.parse(page_html3), Nokogiri::HTML.parse(page_html4), Nokogiri::HTML.parse(page_html5), Nokogiri::HTML.parse(page_html6), Nokogiri::HTML.parse(page_html7), Nokogiri::HTML.parse(page_html8), Nokogiri::HTML.parse(page_html10), Nokogiri::HTML.parse(page_html11), Nokogiri::HTML.parse(page_html12), Nokogiri::HTML.parse(page_html13), Nokogiri::HTML.parse(page_html14), Nokogiri::HTML.parse(page_html15)]
    all_player_data = []

    def strip_html(str)
      nbsp = Nokogiri::HTML("&nbsp;").text
      str.gsub(nbsp,' ')
    end

    nokogiri_objects.each do |nokogiri_object|
      nokogiri_object.xpath('//tr[starts-with(@id, "plyr")]').each do |tr|
        player_info = tr.css('td.playertablePlayerName').text
        player_name = player_info.split(",")[0]
        player_basic = strip_html(player_info.split(",")[1].strip)
        player_team = player_basic.split(" ")[0]
        player_position = player_basic.split(" ")[1]
        injury_object = tr.css('td.playertablePlayerName span')
        def check_if_injury_exists(injury_object)
          if injury_object.text == nil
            return ' '
          else
            injury_object.text
          end
        end
        injury_status = check_if_injury_exists(injury_object)
        league_team = tr.css('td[3] a').text
        stats = tr.css('td.playertableStat')
        minutes = stats[0]
        free_throwsMA = stats[1].text
        free_throws_made = free_throwsMA.split("/")[0]
        free_throws_attempted = free_throwsMA.split("/")[1]
        free_throw_percentage = stats[2].text
        three_pt = stats[3].text
        rebounds = stats[4].text
        assists = stats[5].text
        steals = stats[6].text
        blocks = stats[7].text
        points = stats[8].text

        all_player_data << [player_name, player_team, player_position, injury_status, league_team, minutes, free_throws_made, free_throws_attempted, free_throw_percentage, three_pt, rebounds, assists, steals, blocks, points]
        puts player_name + " " + player_team + " " + player_position + " " + injury_status + " " + league_team + " " + minutes + " " + free_throws_made + " " + free_throws_attempted + " " + free_throw_percentage + " " + three_pt + " " + rebounds + " " + assists + " " + steals +
        " " + blocks +  " " + points
      end
    end
    CSV.open('last7.csv', 'wb') do |row|
      row << ['player_name', 'player_team', 'position', 'injury_status', 'league_team', 'minutes', 'free_throws_made', 'free_throws_attempted', 'free_throw_percentage', 'three_pointers', 'rebounds', 'assists', 'steals', 'blocks', 'points']
      all_player_data.each do |data|
        row << data
      end
    end
    end
end
