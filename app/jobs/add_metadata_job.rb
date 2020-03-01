class AddMetadataJob < ApplicationJob
  queue_as :default
  require 'csv'
  def perform(csv_data,account_id)
    CSV.parse(File.read(csv_data), headers: true) do |row|
	   asset_id = ('0'..'z').to_a.shuffle.first(8).join
	   @media = Media.new(
		    asset_id: asset_id,
		    title: row[0],
		    duration: row[1],
		    file_location: row[2],
		    recorded_time: row[3],
		    account_id: account_id,
		    media_type: row[4]
	    )

	   @media.timecode = @media.duration_tc(row[1])
	   @media.save
	    
	  end
  end
end

