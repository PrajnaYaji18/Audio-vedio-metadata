class MetadataWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  require 'csv'

  def perform(csv_data,account_id,asset_id)
    CSV.parse(File.read(csv_data), headers: true) do |row|
	    byebug
            @media = Media.save(
                    asset_id: asset_id,
                    title: row[0],
                    duration: row[1],
                    file_location: row[2],
                    recorded_time: row[3],
                    account_id: account_id
            )
	    byebug
            @media.save()
          end
    byebug
  end
end


