require "rubygems"
require "google_drive"
require 'nokogiri'
require 'open-uri'
require 'json'
require 'pp'

# Creates a session. This will prompt the credential via command line for the
# first time and save it to config.json file for later usages.
# See this document to learn how to create config.json:
# https://github.com/gimite/google-drive-ruby/blob/master/doc/authorization.md
# session = GoogleDrive.login("juliancito75@gmail.com", "")

def get_the_email_of_a_townhal_from_its_webpage(url)
	page = Nokogiri::HTML(open("#{url}"))
	email = page.xpath('//table/tr[3]/td/table/tr[1]/td[1]/table[4]/tr[2]/td/table/tr[4]/td[2]/p/font')
	email.text

end

def get_all_the_urls_of_seine_maritime_townhalls(url)
	 session = GoogleDrive::Session.from_config("config.json")
	 ws = session.spreadsheet_by_key("1svxTacm_K9Yfz7a7iIH5hOMtGZByc40WH931n-ZIgTw").worksheets[0]
	 towns_mail_list = Hash.new()
	 i = 3

	page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/seine-maritime.html"))
	page.xpath('//a[@class="lientxt"]').each do |town|
		town_name = town.text.downcase
		town_name = town_name.split(' ').join('-')
    proper_town_name = town_name.capitalize
		url = "http://annuaire-des-mairies.com/76/#{town_name}.html"
		towns_mail_list[proper_town_name] = get_the_email_of_a_townhal_from_its_webpage(url)
	end

	 towns_mail_list.each do |key, value|
			puts "#{key}: #{value} "
	#   	 i += 250
    #  		 ws[i, 1] = "#{key}"
    #  		 ws[i, 2] = "#{value}"
   	# 		 ws.save	
	 end
	
		# obj = JSON.parse(json)
		# json = File.read('input.json')
		# pp obj
		myList(ws)
end



get_all_the_urls_of_seine_maritime_townhalls("http://annuaire-des-mairies.com/seine-maritime.html")