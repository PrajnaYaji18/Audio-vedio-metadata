require "csv"
module Api
	module V1
		class MediasController < ApplicationController

# Read file path from API, generate asset ID and Pass the job to AddMetadataJob
#Parameter: Path to CSV file
		
		def create
			@asset_id=('0'..'z').to_a.shuffle.first(8).join
			@path= params[:csv_location]
			@a_id= params[:account_id]
			@data=CSV.read(@path)
			#MetadataWorker.perform_async(@data,@a_id)
			AddMetadataJob.perform_later(@path,@a_id,@asset_id)
		end

# Get the account ID from the request and list all the medias persent in that account
		def index
			@medias = Media.where(account_id: params[:account_id])

			render json: {status: "SUCCESS", message: "Loaded successfully", data:@medias},status: :ok

		end

# Get the account ID and media ID from the request and delete the media
#Parameter: Id of the media
		def destroy
			@media = Media.find_by(account_id: params[:account_id], id: params[:id])	
			@media.destroy		
	       
		  render json: {status: "SUCCESS", message: "Deleted successfully", data:@media},status: :ok
		end

		private
		def media_params
			params.permit(:csv_location)
			
		end
		end
	end
end
