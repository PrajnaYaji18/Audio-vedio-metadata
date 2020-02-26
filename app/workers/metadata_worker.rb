class MetadataWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  require 'csv'

  def perform(csv_data,account_id)
	  byebug
    CSV.parse(csv_data, headers: true) do |row|
      byebug
      print(row[2])
      print(account_id)

  end

    # Do something
  end
end
