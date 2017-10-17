require "google_drive"
require 'gmail'
#require 'gets_emails.rb'


username = 'juliancito75'
password = ''


gmail = Gmail.connect!(username, password)

#puts gmail.inbox.count


session = GoogleDrive::Session.from_config("config.json")
ws = session.spreadsheet_by_key("1svxTacm_K9Yfz7a7iIH5hOMtGZByc40WH931n-ZIgTw").worksheets[0]


for n in 253..256
	if "#{ws[n,2]}".length > 5
		  # puts '#{ws[n,2]}'
		
		myString = "#{ws[n,2]}"

		email = gmail.compose do
		  to "'"+myString+"'"
		  subject "Colossus of Destiny"
		  body "Album disponible sur bandcamp en ecoute gratuite ici : https://colossusofdestiny.bandcamp.com/album/in-lesser-brightness"
		end
		email.deliver!

	end
end
	


gmail.logout 