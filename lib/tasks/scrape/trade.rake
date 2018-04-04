namespace :scrape do
  desc 'Scrape trade data from the ESPN site'
  task :trade => :environment do
    @browser = Watir::Browser.new :chrome
    @browser.goto 'http://games.espn.com/fba/recentactivity?leagueId=219403&seasonId=2017&activityType=2&startDate=20160919&endDate=20170108&teamId=-1&tranType=4'
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
    all_transaction_data = []
    nokogiri_object.search('br').each { |br| br.replace("\n") }
    def awesome_chomp(str)
      str.is_a?(String) ? str.chomp(",") : nil
    end
    #nokogiri_object.search('b').each {|b| b.replace(" ") }
    nokogiri_object.xpath('//table[@class="tableBody"]/tbody/tr[position()>=3]').each do |tr|
      date_time = tr.css('td')[0].text.split("\n")
      date = date_time[0]
      time = date_time[1]
      type = tr.css('td')[1].text.split("\n")
      type_info = type[1]
      #puts type_info
      detail = tr.css('td')[2].text
      extra_lines = tr.css('td')[2].text.split("\n")
      #extra_lines = detail.split("\n")
      def check_number_of_lines(extra_lines)
        info = []
        extra_lines.each do |extra_line|
          team_names1 = extra_line.split(" ")[0]
          player_names1 = extra_line.split(" ")[2] + " " + extra_line.split(" ")[3]
          if team_names1 != extra_lines[0].split(" ")[0]
            team_names2 = extra_lines[0].split(" ")[0]
          else
            team_names2 = extra_lines.last.split(" ")[0]
          end
          info << [team_names1, player_names1, team_names2]
        end
        return info
      end
      team_name = ''
      action = ''
      player_name = ''
      if type_info == 'Trade Processed'
        transaction_info = check_number_of_lines(extra_lines)
        transaction_info.each do |info|
          team_name_out = info[0]
          player_traded = info[1].gsub(/[^a-zA-Z\s]/,'')
          team_name_in = info[2]
          all_transaction_data << [date, time, team_name_out, player_traded, team_name_in]
          puts date + " " + time + " " + team_name_out + " " + player_traded + " " + team_name_in
        end
      end
    end

    CSV.open('trades.csv', 'wb') do |row|
      row << ['date', 'time', 'team_out', 'player_traded', 'team_in']
      all_transaction_data.each do |data|
        row << data
      end
    end
  end
end
