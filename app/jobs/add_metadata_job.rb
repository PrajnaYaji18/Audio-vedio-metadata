class AddMetadataJob < ApplicationJob
  queue_as :default
  require 'csv'
  def perform(csv_data,account_id,asset_id)
    # Do something later
    puts "hiiiiiiiiiiiiiiiiiiiiiiiiiiiii"
    #print(csv_data)
    CSV.parse(File.read(csv_data), headers: true) do |row|
	    Media.create(
		asset_id: asset_id,
		title: row[1],
		duration: row[2],
		file_location: row[3],
		recorded_time: row[4],
		account_id: account_id
	)
	  
    end
    
end
end

